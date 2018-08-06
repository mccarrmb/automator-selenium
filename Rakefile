require 'rake/testtask'
require 'rubocop/rake_task'

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

desc 'Calls out awful code'
RuboCop::RakeTask.new do |t|
  t.fail_on_error = false
end

desc 'Executes internet searches using the Google.com GUI'
Rake::TestTask.new(:test) do |t|
  t.warning = false
  t.test_files = FileList['test/*_test.rb']
end

desc 'Executes tests against all macOS browsers'
Rake::TestTask.new(:macos) do |t|
  t.warning = false
  t.libs << 'macos'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against all Linux browsers'
Rake::TestTask.new(:macos) do |t|
  t.warning = false
  t.libs << 'linux'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against all Windows browsers'
Rake::TestTask.new(:macos) do |t|
  t.warning = false
  t.libs << 'windows'
  t.test_files = FileList['test/**/*_test.rb']
end
task default: ['test']
