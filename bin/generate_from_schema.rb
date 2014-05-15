#!/usr/bin/ruby

require 'optparse'
require 'json'
require 'erb'

options = {}
OptionParser.new do |opts|
  opts.on('-f', '--filename FILENAME', 
    'File containing the json schema to generate puppet manifests for') { |filename| options[:filename] = filename }
  opts.on('--o', '--output DIRECTORY', 'Directory to place generated files') { |directory| options[:output] = directory } 
end.parse!

schema_text = IO.read(options[:filename])
schema = JSON.parse schema_text, :symbolize_names => true

manifest_template_text = IO.read('manifest.erb')
manifest_template = ERB.new(manifest_template_text, safe_mode = nil, trim_mode = '-')

def name_type(type, value)
  return type.to_s if value.to_s == '*'
  "#{type}_#{value}"
end

def puppet_name(attribute_name)
  attribute_name = "_" + attribute_name.to_s if [:title, :name].include? attribute_name 
  attribute_name.to_s.gsub /-/, '_'
end

def collect_types(root, name, node)
  [{
    :path => root + '/',
    :name => name,
    :description => node[:description],
    :attributes => node[:attributes]
  }] +
  if node[:children]
    node[:children].collect {|key, type| 
      if type[:'model-description'].count == 1 && ![:authorization, :connector].include?(key)
        type[:'model-description'].collect{|value_key, value_node| 
          collect_types("#{root}/#{key}=#{value_key}", name_type(key, "*"), value_node) 
        }.flatten 
      else
        type[:'model-description'].collect{|value_key, value_node| 
          collect_types("#{root}/#{key}=#{value_key}", name_type(key, value_key), value_node) 
        }.flatten 
      end
    }.flatten
  else
    []
  end
end

def read_write_attributes(type)
  return {} unless type[:attributes]
  Hash[type[:attributes].select{|key, attr| attr[:'access-type'] != 'metric'}]
end



# File actionview/lib/action_view/helpers/text_helper.rb, line 223
def word_wrap(text, options = {})
  line_width = options.fetch(:line_width, 80)

  text.split("\n").collect! do |line|
    line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
  end * "\n"
end


all_types = collect_types('', 'root_resource', schema[:result])

types_with_write = all_types.select{|t| read_write_attributes(t).count > 0 }

types_by_name = Hash.new([])
types_with_write.each { |t| types_by_name[t[:name]] += [t] }

mismatched_types = types_by_name.select{|name, types| 
  attributes = types.collect {|t| t[:attributes].keys }
  result = attributes.uniq.count != 1
  puts (attributes.uniq.inspect) if result
  result
}
puts mismatched_types.collect{|name, _| name}.inspect

types_to_generate = types_with_write.delete_if {|type| mismatched_types.any? {|name, _| type[:name] == name}}
types_to_generate.each do |type|
  type[:all_attributes] = type[:attributes].clone
  type[:attributes] = read_write_attributes type
end

def generate_type(template, directory, type)
  result = template.result binding

  path = File.join directory, type[:name] + '.pp'
  File.open(path, 'w') { |file| file.write result }
end

types_to_generate.each { |type| generate_type manifest_template, options[:output], type }

#puts manifest_template.result(binding)



