class Conway
  def initialize
    load_map
  end

  LIVE = '1'
  DEAD = '0'

  def live?(x, y)
    unless @map[x].nil? then @map[x][y] == LIVE ? true : false end
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
        if live?(ir, ic)
          tmp_cell += if count(ir, ic).between?(2, 3)
                        LIVE
                      else
                        DEAD
                      end
        else
          tmp_cell += if count(ir, ic) == 3
                        LIVE
                      else
                        DEAD
                      end
        end
      end
      tmp_map << tmp_cell
      tmp_cell = ''
    end
    @map = tmp_map
  end

  def load_map
    file = File.open('conway.map', 'r')
    @map ||= []
    file.each { |line| @map << line }
    file.close
    @map
  end
end
