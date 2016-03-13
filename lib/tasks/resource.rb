require_relative 'schema_generate'

namespace :resource do
  def resource_dir
    File.join Rake.application.original_dir, 'manifests/resource'
  end

  def custom_dir
    File.join Rake.application.original_dir, 'internal/custom_resource'
  end

  def schema_path
    File.join Rake.application.original_dir, 'config/schema.json'
  end

  desc 'Cleans all resource manifests'
  task :clean do
    FileUtils.rm Dir.glob(File.join(resource_dir, '*'))
  end

  desc 'Generates resources based on config schema'
  task :generate_schema => :clean do
    generate_from_schema schema_path, resource_dir 
  end

  desc 'Overlays custom resources on generated resources'
  task :overlay_custom do
    FileUtils.cp Dir.glob(File.join(custom_dir, '*')), resource_dir
  end

  desc 'Generates resources bease on schema and custom resources'
  task :generate => [:generate_schema, :overlay_custom] do
  
  end
end
