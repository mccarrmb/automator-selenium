desc 'Executes tests in parallel against Chrome'
Rake::TestTask.new(:chrome_parallel) do |t|
  t.warning = false
  t.libs = %w[lib tests pages clients/chrome_parallel]
  t.test_files = FileList['tests/**/*_test.rb']
end

desc 'Executes tests in parallel against Firefox'
Rake::TestTask.new(:firefox_parallel) do |t|
  t.warning = false
  t.libs = %w[lib tests pages clients/firefox_parallel]
  t.test_files = FileList['tests/**/*_test.rb']
end

desc 'Executes tests in parallel against Edge'
Rake::TestTask.new(:edge_parallel) do |t|
  t.warning = false
  t.libs = %w[lib tests pages clients/edge_parallel]
  t.test_files = FileList['tests/**/*_test.rb']
end
