#!/usr/bin/env ruby
#
# Copyright 2010 Ning
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# if you get this error:
#
# 'uninitialized constant SOAP::Mapping::EncodedRegistry (NameError)'
#
# you need to follow the bellow steps to work around it
#
# gem uninstall soap4r
# curl -O http://dev.ctor.org/download/soap4r-1.5.8.tar.gz
# tar zxvf soap4r-1.5.8.tar.gz
# cd soap4r-1.5.8
# sudo ruby install.rb

require 'zuora_interface'
require 'zuora/api'
require 'yaml'

class SOAP::Header::HandlerSet
  def reset
    @store = XSD::NamedElements.new
  end

  def set(header)
    reset
    add header
  end
end

module Zuora
  class Client
    API_VERSION = "37.0"
    PROD_URL = "https://www.zuora.com/apps/services/a/#{API_VERSION}"
    SANDBOX_URL = "https://apisandbox.zuora.com/apps/services/a/#{API_VERSION}"

    def self.app_url
      SANDBOX_URL
    end

    def self.config
      return @config_hash if @config_hash
      @config_hash = Zuora::CONFIG if defined?(Zuora::CONFIG)
      @config_hash ||= {}
    end

    def self.parse_custom_fields
      if self.custom_fields
        self.custom_fields.each do |zobject, field_names|
          fields = field_names.map { |e| "#{e.strip}__c" }
          type_class = Object.const_get('ZUORA').const_get(zobject)
          fields.each do |field|
            custom_field = field.gsub(/^\w/) { |i| i.downcase }
            type_class.send :attr_accessor, custom_field
          end
        end
      end
      custom_fields
    end

    def self.custom_fields
      @custom_fields = YAML.load_file(File.dirname(__FILE__) + '/../custom_fields.yml')
    end

    def self.client(force_reload=false, *args)
      return @client if @client && !force_reload
      @client = new(*args)
    end

    def initialize(url=nil)
      $ZUORA_USER = self.class.config["username"]
      $ZUORA_PASSWORD = self.class.config["password"]
      $ZUORA_ENDPOINT = url || self.class.app_url

      @client = ZuoraInterface.new

      # add custom fields, if any
      custom_fields = self.class.parse_custom_fields
      @client.session_start(custom_fields)
    end

    def query(query_string)
      # This will keep calling queryMore until all the results are retreived.

      query_string =~ /select\s+(.+)\s+from/i
      fields = ($1.split /,\s+/).map do |f|
        f.gsub!(/\b\w/) { $&.downcase }
      end

      responses = []
      begin
        responses << @client.api_call(:query, query_string)
        until responses.last.result.done
          responses << @client.api_call(:query_more, responses.last.result.queryLocator)
        end
      rescue Exception => e
        $stderr.puts e.message
      end
      # Capture all the records into one single array.
      responses.map{ |response| response.result.size > 0 ? response.result.records : [] }.flatten
    end

    def subscribe(obj)
      begin
        response = @client.api_call(:subscribe, obj)
        return response
      rescue Exception => e
        puts e.message
      end
    end

    def create(obj)
      begin
        response = @client.api_call(:create,obj)
        result = save_results_to_hash(response)
      rescue Exception => e
        puts e.message
      end
      result || []
    end

    def generate(obj)
      begin
        response = @client.api_call(:generate,obj)
        result = save_results_to_hash(response)
      rescue Exception => e
        puts e.message
      end
      result || []
    end

    def update(obj)
      begin
        response = @client.api_call(:update, obj)
        result = save_results_to_hash(response)
      rescue Exception => e
        puts e.message
      end
      result || []
    end

    def delete(type, ids)
      begin
        response = @client.api_call(:delete, type, ids)
        result = save_results_to_hash(response)
      rescue Exception => e
        puts e.message
      end
      result || []
    end

    def amend(obj)
      @client.api_call(:amend, obj)
    end

    private

    def save_results_to_hash(save_results)
      result = []
      save_results.each do |record|
        row = {:success => record.success}
        if record.success
          row[:id] = record.id
        else
          row[:errors] = []
          record.errors.each do |error|
            row[:errors] << {:message => error.message, :code => error.code}
          end
        end
        result << row
      end
      result
    end
  end

end
