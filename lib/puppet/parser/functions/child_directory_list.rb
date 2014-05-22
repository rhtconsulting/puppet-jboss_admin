require 'pathname'

Puppet::Parser::Functions.newfunction(:child_directory_list, :type => :rvalue) do |args|
  raise "Illegal number of arguments" unless args.count == 2
  base_path, child_path = args

  result = []
  Pathname.new(child_path).descend{|child| result << File.join(base_path, child)}

  result
end
