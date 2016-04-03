class Field
  def initialize
    load_map
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

  def rand_start(cols = 64, rows = 48)
    # @map = Array.new(rows, '0' * cols)
    # @map.each_with_index do |row, i|
      # random figure doesnt work
      # row[rand(29..35)] = LIVE if i == 24
    # end
    # @map
  end

  def create_empty_map(cols = 64, rows = 48)
    file = File.open('conway.map', 'w+')    
    default_map_size(cols, rows).each { |row| file.puts(row) }
    file.close
  end
end