require 'gosu'
require_relative 'conway'

class GameWindow < Gosu::Window
  def initialize(height = 640, width = 480)
    super height, width, { update_interval: 200, fullscreen: false }
    self.caption = 'Conway'
    @background = Gosu::Color.new(0xffdedede)
    @alive = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)
    # TODO: make cell size to be dependent on map size
    @cell_h = 10
    @cell_w = 10
    @gen = 0
    @cell = Conway.new
    @font = Gosu::Font.new(20)
  end

  def update
    # _
  end

  def draw
    draw_background
    draw_frame
    @gen += 1
    @font.draw("Generations: #{@gen}", 10, 10, 0, 1.0, 1.0, 0xff_5e5e5e)
  end

  def draw_frame
    @cell.generate_next.each_with_index do |row, ir|
      row.chars.each_with_index do |_, ic|
        @cell.live?(ir, ic) ? draw_cell(ic, ir, @alive) : draw_cell(ic, ir, @dead)
      end
    end
  end

  def draw_cell(ic, ir, status)
    draw_quad(ic * @cell_w, ir * @cell_h, status,
              ic * @cell_w + (@cell_w - 1), ir * @cell_h, status,
              ic * @cell_w + (@cell_w - 1), ir * @cell_h + (@cell_h - 1), status,
              ic * @cell_w, ir * @cell_h + (@cell_h - 1), status)
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
