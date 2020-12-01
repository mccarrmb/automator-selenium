# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

# Load all task files
Dir['tasks/**/*.rake'].each { |rake| load rake }

desc 'Start a console session with Selenium loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'pry'
  require 'minitest/autorun'
  require 'minitest/unit'
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

task default: ['chrome']
