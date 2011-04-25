require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
require 'rcov/rcovtask'

task :default => [:test]

task :test do
  Rake::TestTask.new do |t|
    t.libs << 'spec'
    t.pattern = 'spec/**/*_spec.rb'
    t.verbose = true
  end
end

Rcov::RcovTask.new do |test|
  test.libs << 'spec'
  test.pattern = 'spec/**/*_spec.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end
