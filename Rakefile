require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "active_zuora"
    gem.summary = "Active Zuora"
    gem.description = "A client for Zuora API"
    gem.email = "andy.fleener@tstmedia.com"
    gem.homepage = "http://github.com/tstmedia/active_zuora"
    gem.authors = ["Andy Fleener", "Ed Lebert", "Nate Greene"]
    gem.files = FileList["CHANGES", "active_zuora.gemspec", "Rakefile", "README", "VERSION", "custom_fields.yml",
        "lib/**/*"]
    gem.add_dependency "mumboe-soap4r", ">= 1.5.8"
    gem.add_dependency "json_pure", ">= 1.4.6"        
    gem.requirements = ["none"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

