module Zuora
  class ZObject < SimpleDelegator
    def initialize(attributes={})
      super(self.class.zobject_class.new).tap do |zobject|
        attributes.each do |attr, value|
          zobject.send("#{attr}=", self.class.convert_date(value))
        end
      end
    end

    def self.new_from_zobject(zobject)
      self.new.tap do |active_zobject|
        active_zobject.__setobj__(zobject)
      end
    end

    def to_zobject
      __getobj__
    end

    def id
      __getobj__.id
    end

    def type
      __getobj__.type
    end

    def ==(another)
      id == another.id && another.respond_to?(:zobject_class) && zobject_class == another.zobject_class
    end

    def attributes
      Hash.new.tap do |hash|
        self.class.attribute_names.each do |attr|
          hash[attr] = __getobj__.send(attr)
        end
      end
    end

    # Any attributes that are Dates should be created as a 
    # DateTime in the PST timezone.
    # Zuora doesn't actually use the time portion of any Datetime field.
    # All that matters is the date.
    def self.convert_date(value)
      if value.is_a?(Date) || value.is_a?(DateTime) || value.is_a?(Time)
        DateTime.new(value.year, value.month, value.day, 0, 0, 0, "-0800")
      else
        value
      end
    end

    def destroy
      self.class.destroy(id)
    end

    def self.destroy(ids)
      self.client.delete(self.klass_name, [ids].flatten)
    end

    def self.create(attributes={})
      self.client.create([self.new(attributes).to_zobject])
    end

    def self.update_attributes(attributes={})
      self.client.update([self.new(attributes).to_zobject])
    end

    def self.zobject_class
      return @zobject_class if @zobject_class

      if ZUORA.const_defined?(self.klass_name)
        @zobject_class = ZUORA.const_get(self.klass_name)
      else
        @zobject_class = self.superclass.respond_to?(:zobject_class) ? self.superclass.zobject_class : ZUORA.const_missing(self.klass_name)
      end
    end

    def zobject_class
      self.class.zobject_class
    end

    def self.klass_name
      @klass_name ||= name.split("::").last
    end

    #TODO: This sucks attributes need to be clearly defined
    def self.attribute_names
      @attribute_names ||= zobject_class.instance_variable_get("@attributes")
    end

    def self.query_attribute_names(options={})
      excluded_attributes = []
      excluded_attributes.concat excluded_query_attributes unless options[:include_excluded]
      excluded_attributes.concat extra_attributes unless options[:include_extras]
      attribute_names - excluded_attributes
    end

    def self.exclude_query_attributes(*attributes)
      excluded_query_attributes.concat attributes
    end

    def self.excluded_query_attributes
      @excluded_query_attributes ||= [:fieldsToNull]
    end

    def self.extra_attributes(attributes=[])
      attributes
    end

    def self.where(conditions={}, options={})
      # You can give a hash or a string for the conditions
      conditions = build_filter_statments(conditions) if conditions.is_a? Hash
      query = "select #{self.query_attribute_names(options).join(", ")} from #{self.name.gsub(/Zuora::/,"")} where #{conditions}"
      puts query if $DEBUG
      zobjects = self.client.query(query)
      zobjects.map{|zobject| self.new_from_zobject zobject }
    end

    def self.build_filter_statments(filter_statments)
      filter_statments.map{|key, value|
        value = "'#{value}'" if value.kind_of?(String)
        value = "null" if value.nil?
        "#{key} = #{value}"
      }.join(" and ")
    end

    def self.find(id)
      nil unless valid_id(id)
      query = "select #{query_attribute_names(:include_extras => true).join(", ")} from #{self.name.gsub(/Zuora::/,"")} where Id = '#{id}'"
      puts query if $DEBUG
      zobject = client.query(query).first
      new_from_zobject zobject if zobject
    end

    def self.valid_id(id)
      id.to_s.size == 32 && id.hex.to_s(16) == id
    end

    def self.all(options={})
      zobjects = client.query("select #{query_attribute_names(options).join(", ")} from #{self.name.gsub(/Zuora::/,"")}")
      zobjects.map{|zobject| self.new_from_zobject zobject }
    end

    def self.client
      return @client if @client && self.valid_session?
      @session_start_time = Time.now
      @client = Zuora::Client.new
    end

    def self.valid_session?
      #session is valid if it has been running for less than 8 hours
      @session_start_time + 28800 > Time.now
    end
  end
end
