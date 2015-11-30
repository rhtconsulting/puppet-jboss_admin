class PathGenerator

  def self.format_path(path)
    '/' + path.collect { |segment| "#{segment.first[0]}=#{segment.first[1]}"}.join('/')
  end

  def self.format_command(path, method, arguments)
    format_path(path) + ':' + method + arguments
  end

  def self.ancestors_and_self(path)
    (0..path.count()).map { |count|
      format_path(path.take(count))
    }
  end

  def self.ancestors(path)
    (0..path.count() - 1).map { |count|
      format_path(path.take(count))
    }
  end

  # Finds the position in the given root_dump_json of the given CLI path
  #
  # path:           CLI path to find in the given root_dump_json
  # root_dump_json: JSON representation of a root dump of the CLI to search 
  #
  # return: the value at the position in the root_dump_json specified by the given CLI path,
  #         or nil if not found.
  def self.root_dump_position(path, root_dump_json)
    # parse the CLI path
    flattened_path = path.collect{|entry| entry.to_a}.flatten

    # search for the CLI path in the root CLI dump
    previous_pos = nil 
    current_pos = root_dump_json
    flattened_path.each { |step|
      previous_pos = current_pos
      current_pos  = current_pos[step]

      # if address not found, check if step is wrapped in quotes and if so remove the quotes and try again
      #
      # Examples:
      #   CLI address: /subsystem=naming/binding="java:/comp/env/MY_BINDING_0"
      #   root dump position: subsystem -> naming -> binding -> java:/comp/env/MY_BINDING_0
      if current_pos.nil? && step =~ /^"([^"]*)"$/
        current_pos = previous_pos[$1] # $1 contains the first capture group from the last regular expression
      end

      # if address not found, check the level above for a 'configuration' namespace
      #   
      # Examples:
      #   CLI address: /subsystem=web/virtual-server=default-host/access-log=configuration
      #   root dump position: subsystem -> web -> virtual-server -> default-host -> access-log
      if current_pos.nil? && !previous_pos['configuration'].nil?
        current_pos = previous_pos['configuration'][step]
      end 

      # if address not found, check the level above for a 'setting' namespace
      #   
      # Examples:
      #   CLI address: /subsystem=web/virtual-server=default-host/access-log=configuration/directory=configuration
      #   root dump position: subsystem -> web -> virtual-server -> default-host -> access-log -> setting -> directory
      if current_pos.nil? && !previous_pos['setting'].nil?
        current_pos = previous_pos['setting'][step]
      end 

      # if address not found, and this is the last step of the address, and that step is a configuraiton step,
      # use the previous step
      #   
      # Examples:
      #   CLI address: /subsystem=web/virtual-server=default-host/access-log=configuration
      #   root dump position: subsystem -> web -> virtual-server -> default-host -> access-log
      #   
      #   CLI address: /subsystem=web/virtual-server=default-host/access-log=configuration/directory=configuration
      #   root dump position: subsystem -> web -> virtual-server -> default-host -> access-log -> setting -> directory
      if current_pos.nil? && step == 'configuration'
        current_pos = previous_pos
      end 

      break if current_pos.nil?
    }

    current_pos
  end

end
