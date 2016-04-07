require 'gosu'
require_relative 'conway'

class GameWindow < Gosu::Window

  def initialize(height = 640, width = 480)
    @height = height
    @width = width
    super height, width, false
    self.caption = "Conway"
    @background = Gosu::Color.new(0xffdedede)
    @alive = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)
    @rows = height/10
    @cols = width/10
    @row_height = height/@rows
    @col_width = width/@cols
    @gen = 0

    @cell = Conway.new

    @font = Gosu::Font.new(20)
  end

  def update
    sleep 0.2
  end

  def draw
    draw_background
    @cell.generation_next.each_with_index do |row, ir|
      row.chars.each_with_index do |_, ic|
        if @cell.live?(ir, ic)
          drawq(ic, ir, @alive)
        else
          drawq(ic, ir, @dead)
        end
      end
    end
    @gen += 1
    @font.draw("Generations: #{@gen}", 10, 10, 0, 1.0, 1.0, 0xff_5e5e5e)
  end

  def drawq(ic, ir, status)
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