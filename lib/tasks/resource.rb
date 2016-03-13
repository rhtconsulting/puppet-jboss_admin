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

  def schema_eap_path
    File.join Rake.application.original_dir, 'config/schema.eap'
  end

  desc 'Cleans all resource manifests'
  task :clean do
    FileUtils.rm Dir.glob(File.join(resource_dir, '*'))
  end

  desc 'Generates resources based on config schema'
  task :generate_from_schema => :clean do
    generate_from_schema schema_path, resource_dir 
  end

  desc 'Overlays custom resources on generated resources'
  task :overlay_custom do
    FileUtils.cp Dir.glob(File.join(custom_dir, '*')), resource_dir
  end

  desc 'Generates resources bease on schema and custom resources'
  task :generate => [:generate_from_schema, :overlay_custom] do
  end

  desc 'Gets the CLI resource descriptions from JBoss EAP CLI'
  task :get_cli_resource_descriptions do
    schema_eap = `/usr/share/jbossas/bin/jboss-cli.sh -c "/:read-resource-description(recursive=true)"`
    IO.write(schema_eap_path, schema_eap)
  end

  desc 'Create the json schema from the CLI resource descriptions'
  task :create_schema do
    schema_text = IO.read(schema_eap_path)

    # convert the eap output to json
    schema_json = schema_text
      .gsub(/ => undefined/, ': null')
      .gsub(/ => big decimal/, ': ')
      .gsub(/=>/, ':')
      .gsub(/: expression/, ': ')
      .gsub(/^\s*"(type|value-type)"\s*:\s+([^{,\n]+)/,'"\1": "\2"')
      .gsub(/\}\n\{/m, "},{")
      .gsub(/\n/, '')
      .gsub(/\t/, '    ')
      .gsub(/ (-?\d+)L/, ' \1')
      .gsub(/bytes\s*\{([^\}]*)\}/,'"bytes {\1}"')

    # write out the json
    IO.write(schema_path, schema_json)
  end

  desc 'Update the schema from the JBoss CLI'
  task :generate_schema => [:get_cli_resource_descriptions, :create_schema] do
  end
end
