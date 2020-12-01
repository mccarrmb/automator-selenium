# frozen_string_literal: true

desc 'Executes tests against Chrome'
Rake::TestTask.new(:chrome) do |t|
  t.warning = false
  t.libs = %w[lib pages clients/chrome]
  t.test_files = FileList['tests/**/*_test.rb']
end

desc 'Executes tests against Firefox'
Rake::TestTask.new(:firefox) do |t|
  t.warning = false
  t.libs = %w[lib pages clients/firefox]
  t.test_files = FileList['tests/**/*_test.rb']
end

desc 'Executes tests against Safari'
Rake::TestTask.new(:safari) do |t|
  t.warning = false
  t.libs = %w[lib pages clients/safari]
  t.test_files = FileList['tests/**/*_test.rb']
end

desc 'Executes tests against Edge'
Rake::TestTask.new(:edge) do |t|
  t.warning = false
  t.libs = %w[lib pages clients/edge]
  t.test_files = FileList['tests/**/*_test.rb']
end
