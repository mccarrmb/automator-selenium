require 'rake/testtask'

desc 'Start a console session with Selenium loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'selenium-webdriver'
  require 'page-object'
  require 'page-object/page_factory'

  ARGV.clear
  IRB.start
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new do |t|
  t.fail_on_error = false
end

desc 'Executes internet searches using the Google.com GUI'
Rake::TestTask.new(:test) do |t|
  t.warning = false
  t.test_files = FileList['test/**/*_test.rb'] 
end 

task default: ['test']

