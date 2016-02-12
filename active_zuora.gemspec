# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: active_zuora 1.4.21 ruby lib

Gem::Specification.new do |s|
  s.name = "active_zuora"
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Andy Fleener", "Ed Lebert", "Nate Greene"]
  s.date = "2015-04-10"
  s.description = "A client for Zuora API"
  s.email = "andy.fleener@tstmedia.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "Rakefile",
    "VERSION",
    "active_zuora.gemspec",
    "custom_fields.yml",
    "lib/active_zuora.rb",
    "lib/active_zuora/account.rb",
    "lib/active_zuora/amendment.rb",
    "lib/active_zuora/bill_run.rb",
    "lib/active_zuora/contact.rb",
    "lib/active_zuora/invoice.rb",
    "lib/active_zuora/invoice_item.rb",
    "lib/active_zuora/invoice_item_adjustment.rb",
    "lib/active_zuora/invoice_payment.rb",
    "lib/active_zuora/payment.rb",
    "lib/active_zuora/payment_method.rb",
    "lib/active_zuora/product.rb",
    "lib/active_zuora/product_rate_plan.rb",
    "lib/active_zuora/product_rate_plan_charge.rb",
    "lib/active_zuora/product_rate_plan_charge_tier.rb",
    "lib/active_zuora/product_rate_plan_charge_tier_data.rb",
    "lib/active_zuora/rate_plan.rb",
    "lib/active_zuora/rate_plan_charge.rb",
    "lib/active_zuora/rate_plan_charge_data.rb",
    "lib/active_zuora/rate_plan_charge_tier.rb",
    "lib/active_zuora/rate_plan_data.rb",
    "lib/active_zuora/refund.rb",
    "lib/active_zuora/subscribe_options.rb",
    "lib/active_zuora/subscribe_request.rb",
    "lib/active_zuora/subscribe_with_existing_account_request.rb",
    "lib/active_zuora/subscription.rb",
    "lib/active_zuora/subscription_data.rb",
    "lib/active_zuora/usage.rb",
    "lib/active_zuora/zobject.rb",
    "lib/soap/property",
    "lib/zuora/ZUORA.rb",
    "lib/zuora/ZUORADriver.rb",
    "lib/zuora/ZUORAMappingRegistry.rb",
    "lib/zuora/ZuoraServiceClient.rb",
    "lib/zuora/api.rb",
    "lib/zuora_client.rb",
    "lib/zuora_interface.rb"
  ]
  s.homepage = "http://github.com/tstmedia/active_zuora"
  s.requirements = ["none"]
  s.rubygems_version = "2.4.6"
  s.summary = "Active Zuora"
  s.add_dependency('soap4r-ng')
  s.add_development_dependency('rake')
  s.add_development_dependency('test-unit')
end

