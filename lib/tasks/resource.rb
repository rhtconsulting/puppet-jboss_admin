require_relative 'generate'

namespace :resource do
  def resource_dir
    File.join Rake.application.original_dir, 'manifests/resource'
  end

  def custom_dir
    File.join Rake.application.original_dir, 'internal/custom_resource'
  end

  def resource_descriptions_json_path
    File.join Rake.application.original_dir, 'staging/resource_descriptions.json'
  end

  def resource_descriptions_path
    File.join Rake.application.original_dir, 'staging/resource_descriptions'
  end

  def default_jboss_cli
    '/opt/jboss/bin/jboss-cli.sh'
  end

  desc 'Cleans all resource Puppet manifests'
  task :clean do
    FileUtils.rm Dir.glob(File.join(resource_dir, '*'))
  end

  desc 'Generates resources based on resource descriptions JSON'
  task :generate_from_json_resource_descriptions => :clean do
    generate_from_json_resource_descriptions(resource_descriptions_json_path, resource_dir)
  end

  desc 'Overlays custom resources on generated resources'
  task :overlay_custom do
    FileUtils.cp Dir.glob(File.join(custom_dir, '*')), resource_dir
  end

  desc 'Generates resources beased on resource descriptions and custom resources'
  task :generate => [:generate_from_json_resource_descriptions, :overlay_custom] do
  end

  desc 'Gets the CLI resource descriptions'
  task :get_cli_resource_descriptions, [:jboss_cli] do |task, args|
    args.with_defaults(:jboss_cli => default_jboss_cli)

    # get the resource definitions from the jboss-cli
    resource_descriptions      = `#{args[:jboss_cli]} -c "/:read-resource-description(recursive=true)"`
    resource_descriptions_exit = $?

    # write the resource definitions to file
    if resource_descriptions_exit == 0

      # write out the CLI resource descriptions
      parent_dir = File.dirname(resource_descriptions_path)
      FileUtils.mkdir_p(parent_dir) unless File.directory?(parent_dir)
      File.open(resource_descriptions_path, 'w+') do |resource_descriptions_file|
        resource_descriptions_file.write(resource_descriptions)
      end
    else
      fail "ERROR: Could not read resource descriptions from JBoss CLI."
    end
  end

  desc 'Transform the CLI resource descriptions to JSON resource descriptions'
  task :transform_cli_to_json_resource_descriptions do
    resource_descriptions = File.read(resource_descriptions_path)

    # convert the eap output to json
    resource_descriptions_json = resource_descriptions
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
    parent_dir = File.dirname(resource_descriptions_json_path)
    FileUtils.mkdir_p(parent_dir) unless File.directory?(parent_dir)
    File.open(resource_descriptions_json_path, 'w+') do |resource_descriptions_json_file|
      resource_descriptions_json_file.write(resource_descriptions_json)
    end
  end

  desc 'Generate JSON resource descripitions'
  task :generate_json_resource_descriptions, [:jboss_cli] => [:get_cli_resource_descriptions, :transform_cli_to_json_resource_descriptions] do
  end
end
