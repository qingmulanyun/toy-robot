require_relative '../lib/simulator'

describe Simulator do
  before(:each) do
    @sim = Simulator.new
  end
    
  context "#start" do
    it 'should start commands' do
      @sim.start("PLACE 0,0,NORTH")
      expect(STDOUT).to receive(:puts).with('0, 0, NORTH')
      @sim.robot.report
    
      @sim.start("MOVE")
      @sim.start("RIGHT")
      @sim.start("MOVE")
    
      expect(STDOUT).to receive(:puts).with('1, 1, EAST')
      @sim.robot.report
    
      # if it goes out of the board it ignores the command
      for i in 0..3
        @sim.start("MOVE");
      end
      expect(STDOUT).to receive(:puts).with('5, 1, EAST')
      @sim.robot.report

      # rotate on itself
      for i in 0..3
        @sim.start("LEFT");
      end
      expect(STDOUT).to receive(:puts).with('5, 1, EAST')
      @sim.robot.report
    end

    it 'should ignore invalid commands' do
      expect { @sim.start("123") }.to raise_error(Exceptions::Command::InvalidCommand)
      expect { @sim.start("LEFFT") }.to raise_error(Exceptions::Command::InvalidCommand)
      expect { @sim.start("RIGHTT") }.to raise_error(Exceptions::Command::InvalidCommand)
    end
  end
end