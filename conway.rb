class Conway
  def initialize
    load_map
  end

  LIVE = '1'.freeze
  DEAD = '0'.freeze

  def live?(x, y)
    unless @map[x].nil? then
      @map[x][y] == LIVE ? true : false
    end
  end

  def count(x, y)
    i = 0
    i += 1 if live?(x - 1, y - 1)
    i += 1 if live?(x - 1, y)
    i += 1 if live?(x - 1, y + 1)
    i += 1 if live?(x, y - 1)
    i += 1 if live?(x, y + 1)
    i += 1 if live?(x + 1, y - 1)
    i += 1 if live?(x + 1, y)
    i += 1 if live?(x + 1, y + 1)
    i
  end

  def generate_next
    tmp_map = []
    tmp_cell = ''
    @map.each_with_index do |row, ir|
      row.chars.each_with_index do |_, ic|
        tmp_cell += set_status(ir, ic)
      end
      tmp_map << tmp_cell
      tmp_cell = ''
    end
    @map = tmp_map
  end

  def set_status(ir, ic)
    case count(ir, ic)
      when 2
        live?(ir, ic) ? LIVE : DEAD
      when 3
        LIVE
      else
        DEAD
    end
  end

  def load_map
    file = File.open('conway.map', 'r')
    @map ||= []
    file.each { |line| @map << line }
    file.close
    @map
  end
end
