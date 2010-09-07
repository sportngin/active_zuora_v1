# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{zuora4r}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cloocher"]
  s.date = %q{2010-09-07}
  s.description = %q{A client for Zuora API}
  s.email = %q{gene@ning.com}
  s.executables = ["zuora-query", "zuora-bill-run", "zuora-payment-run", "zuora-delete", "zq"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "Rakefile",
     "bin/zq",
     "bin/zuora-bill-run",
     "bin/zuora-delete",
     "bin/zuora-payment-run",
     "bin/zuora-query",
     "lib/zuora/ZUORA.rb",
     "lib/zuora/ZUORADriver.rb",
     "lib/zuora/ZUORAMappingRegistry.rb",
     "lib/zuora/ZuoraServiceClient.rb",
     "lib/zuora/api.rb",
     "lib/zuora_client.rb",
     "lib/zuora_interface.rb",
     "zuora4r.gemspec"
  ]
  s.homepage = %q{http://github.com/cloocher/zuora4r}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.requirements = ["none"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Zuora4r}
  s.test_files = [
    "test/helper.rb",
     "test/test_zuora_client.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<soap4r>, [">= 1.5.8"])
      s.add_runtime_dependency(%q<json_pure>, [">= 1.4.6"])
    else
      s.add_dependency(%q<soap4r>, [">= 1.5.8"])
      s.add_dependency(%q<json_pure>, [">= 1.4.6"])
    end
  else
    s.add_dependency(%q<soap4r>, [">= 1.5.8"])
    s.add_dependency(%q<json_pure>, [">= 1.4.6"])
  end
end

