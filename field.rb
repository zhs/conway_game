class Field
  def initialize(map = load_map)
    @map = map
  end

  def default_map_size(cols, rows)
    @map = Array.new(rows, '0' * cols)
  end

  def source
    @map 
  end

  def load_map
    file = File.open('conway.map', 'r')
    @map ||= []
    file.each { |line| @map << line }
    file.close
    @map
  end

  def create_empty_map(cols = 64, rows = 48)
    file = File.open('conway.map', 'w+')    
    default_map_size(cols, rows).each { |row| file.puts(row) }
    file.close
  end
end