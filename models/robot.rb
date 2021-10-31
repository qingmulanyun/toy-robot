require_relative '../exceptions/command'
require_relative '../exceptions/tabletop'
require_relative '../lib/constants'
# require 'byebug'

class Robot
  attr_accessor :position, :facing, :tabletop, :placed_in

  def initialize(tabletop)
    raise ArgumentError if tabletop.nil?
    @tabletop = tabletop
    @placed_in = false
  end

  def place(x, y, f)
    raise  Exceptions::Command::InvalidCommand, 'invalid position' unless (x.is_a? Integer) && (y.is_a? Integer)
    raise  Exceptions::Command::InvalidCommand, 'invalid facing' unless Constants::Robot::FACING.member?(f)
    raise Exceptions::Tabletop::OutOfTabletop if tabletop.out_of_tabletop?(x, y)

    @position = {x: x, y: y }
    @facing = f
    @placed_in = true #flag to check if a robot has been placed to the tabletop
  end

  def move
    next_x = @position[:x]
    next_y = @position[:y]
    case @facing
    when Constants::Robot::NORTH
      next_y += 1
    when Constants::Robot::EAST
      next_x += 1
    when Constants::Robot::SOUTH
      next_y -= 1
    when Constants::Robot::WEST
      next_x += 1
    end
    
    raise Exceptions::Tabletop::OutOfTabletop, 'ignored, invalid move' if tabletop.out_of_tabletop?(next_x, next_y)
    @position = { x: next_x, y: next_y }
  end

  # Facing is declared as an array with order N -> E -> S -> W. A cyclic array could easily represent turning facing.
  def turn_right
    idx = Constants::Robot::FACING.index(@facing)
    @facing = Constants::Robot::FACING[(idx + 1) % Constants::Robot::FACING.size]
  end

  def turn_left
    idx = Constants::Robot::FACING.index(@facing)
    @facing = Constants::Robot::FACING[idx - 1]
  end

  def report
    puts "#{@position[:x]}, #{@position[:y]}, #{@facing}"
  end
end