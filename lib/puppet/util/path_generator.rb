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

end
