
begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

task :default => 'test:run'
task 'gem:release' => 'test:run'

Bones {
  name     'display_edit_distance_operations'
  authors  'Vicente Bosch'
  email  'vbosch@gmail.com'
  url  'http://github.com/vbosch/display_edit_distance_operations'
  ignore_file  '.gitignore'
}

