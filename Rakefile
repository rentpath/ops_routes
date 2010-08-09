require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ops_routes"
    gem.summary = %Q{Plugin or middleware that provides version and heartbeat pages for app monitoring}
    gem.description = %Q{Installs as Rails plugin or Rack middleware for non-Rails apps}
    gem.email = ""
    gem.homepage = "http://github.com/primedia/ops_routes"
    gem.authors = ["Primedia Team"]
    gem.add_dependency "rack", "~> 1.0"
    gem.add_dependency "haml", "~> 3.0.0" 
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "rack-test"
    gem.add_development_dependency 'rspec_tag_matchers'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ops_routes #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
