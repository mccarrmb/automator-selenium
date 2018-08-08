desc 'Executes tests against Chrome'
Rake::TestTask.new(:chrome) do |t|
  t.warning = false
  t.libs = %w[lib test pages test/chrome]
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against Firefox'
Rake::TestTask.new(:firefox) do |t|
  t.warning = false
  t.libs = %w[lib test pages test/firefox]
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against Safari'
Rake::TestTask.new(:safari) do |t|
  t.warning = false
  t.libs = %w[lib test pages test/safari]
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against Edge'
Rake::TestTask.new(:edge) do |t|
  t.warning = false
  t.libs = %w[lib test pages test/edge]
  t.test_files = FileList['test/**/*_test.rb']
end
