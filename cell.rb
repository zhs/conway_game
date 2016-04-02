class Cell
  def initialize(map = Field.new)
    @map = map.source
  end

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

  def generation_next
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

  def show_gen(n)
    # show 1st gen
    @map.each(&output)
    refresh

    n.times do
      generation_next.each(&output)
      refresh
    end
  end

  def output
    -> (x) { puts x.tr('0', ' ').tr('1', '*') }
  end

  def refresh(sec = 0.2)
    puts '-' * @map[0].length
    sleep sec
    system 'clear'
  end
end
