require 'rake/testtask'
require 'rubocop/rake_task'

Dir['tasks/**/*.rake'].each { |rake| load rake }

desc 'Start a console session with Selenium loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'pry'
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

# Parallel local tests
desc 'Executes tests against all macOS browsers in parallel (except Safari)'
multitask macos_parallel: %w[chrome_parallel firefox_parallel safari]

desc 'Executes tests against all Linux browsers in parallel'
multitask linux_parallel: %w[chrome_parallel firefox_parallel]

desc 'Executes tests against all Windows browsers in parallel'
multitask windows_parallel: %w[chrome_parallel firefox_parallel edge_parallel]

# Non-parallel local tests (all browsers are run concurrently, however)
desc 'Executes tests against all macOS browsers'
multitask macos: %w[chrome firefox safari]

desc 'Executes tests against all Linux browsers in parallel'
multitask linux: %w[chrome firefox]

desc 'Executes tests against all Windows browsers in parallel'
multitask windows: %w[chrome firefox edge]

# The default task is set to local instance of firefox 
# as it is the easiest driver to set up.
task default: ['firefox']
