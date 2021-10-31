require_relative '../lib/simulator'

simulator = Simulator.new
puts "# Toy robot Simulator"

if ARGV[0]
  puts "# Robot is following the given instruction from the file."
  File.open(ARGV[0], "r").each_line do |command_str|
    command_str.strip!

    simulator.exec(command_str)
  end
else
  puts "# Please enter a PLACE command first."
  puts "# Valid commands are:"
  puts "# \'PLACE X,Y,NORTH|SOUTH|EAST|WEST\', MOVE, LEFT, RIGHT ,REPORT or EXIT"
  STDIN.each_line do |input_str|
    input_str.strip!

    if input_str.downcase == "exit"
      puts "# Bye"
      exit
    end

    simulator.exec(input_str)
  end
end
