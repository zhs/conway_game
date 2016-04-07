require 'gosu'
require_relative 'conway'

class GameWindow < Gosu::Window

  def initialize(height = 640, width = 480)
    super height, width, {update_interval: 200, fullscreen: false}
    self.caption = "Conway"
    @background = Gosu::Color.new(0xffdedede)
    @alive = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)
    @row_height = 10
    @col_width = 10
    @gen = 0
    @cell = Conway.new
    @font = Gosu::Font.new(20)
  end

  def update
    # _
  end

  def draw
    draw_background
    @cell.generate_next.each_with_index do |row, ir|
      row.chars.each_with_index do |_, ic|
        if @cell.live?(ir, ic)
          draw_cell(ic, ir, @alive)
        else
          draw_cell(ic, ir, @dead)
        end
      end
    end
    @gen += 1
    @font.draw("Generations: #{@gen}", 10, 10, 0, 1.0, 1.0, 0xff_5e5e5e)
  end

  def draw_cell(ic, ir, status)
    draw_quad(ic * @col_width, ir * @row_height, status,
              ic * @col_width + (@col_width - 1), ir * @row_height, status,
              ic * @col_width + (@col_width - 1), ir * @row_height + (@row_height - 1), status,
              ic * @col_width, ir * @row_height + (@row_height - 1), status)
    
  end

  def button_down(id)
    case id
    when Gosu::KbSpace
      # _
    when Gosu::KbEscape
      close
    end
  end

  def needs_cursor?
    true
  end

  def draw_background
    draw_quad(0, 0, @background,
              width, 0, @background,
              width, height, @background,
              0, height, @background)
  end

end

GameWindow.new.show