require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "active_zuora"
    gem.summary = "Active Zuora"
    gem.description = "A client for Zuora API"
    gem.email = "anfleene@gmail.com"
    gem.homepage = "http://github.com/anfleene/active_zuora"
    gem.authors = ["anfleene"]
    gem.files = FileList["CHANGES", "active_zuora.gemspec", "Rakefile", "README", "VERSION", "custom_fields.yml",
        "lib/**/*"]
    gem.add_dependency "soap4r", ">= 1.5.8"
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

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "active_zuora #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
