class Field
  def initialize(map = default_map_size)
    @map = map
  end

  def default_map_size(size = 10)
    @map = Array.new(size, '0' * size)
  end

  def source
    @map
  end

  def load_map
    file = File.open('conway.map', 'r')
    @map.clear
    file.each { |line| @map << line }
    file.close
  end

  def create_empty_map(size = 50)
    file = File.open('conway.map', 'w+')
    default_map_size(size).each { |row| file.puts row }
    file.close
  end
end
