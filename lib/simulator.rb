require_relative '../models/robot'
require_relative '../models/tabletop'

class Simulator
  attr_accessor :robot, :tabletop

  def initialize
    @tabletop = Tabletop.new(5, 5)
    @robot = Robot.new(@tabletop)
  end

  def exec(input_str)
    begin
      start(input_str)
    rescue Exception => e
      puts e.message
    end
  end

  def start(input_str)
    inputs = input_str.split(' ').map(&:strip)
    command = inputs.first
    params = inputs.last
    raise Exceptions::Command::InvalidCommand unless Constants::Robot::COMMANDS.include?(command)
    
    check_robot_placed_in if command != Constants::Robot::PLACE

    case command
    when Constants::Robot::PLACE
      ps = params.split(',')
      raise Exceptions::Command::InvalidCommand if ps.size < 3
      @robot.place(ps[0].to_i, ps[1].to_i, ps[2])
    when Constants::Robot::MOVE
      @robot.move
    when Constants::Robot::LEFT
      @robot.turn_left
    when Constants::Robot::RIGHT
      @robot.turn_right
    when Constants::Robot::REPORT
      @robot.report
    end
  end

  def check_robot_placed_in
    raise Exceptions::Command::InvalidCommand, 'Invalid command, please PLACE the Robot first.' unless @robot.placed_in
  end
end