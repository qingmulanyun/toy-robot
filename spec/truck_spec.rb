require 'spec_helper'

describe Robot do
  before(:each) do
    @tabletop = Tabletop.new(5, 5)
    @robot = Robot.new(@tabletop)
  end

  context "#place" do
    it 'place correctly' do
      expect(@robot.place(0, 1, 'NORTH')).to eq(true)
      expect(@robot.place(2, 2, 'EAST')).to eq(true)
      expect(@robot.place(4, 4, 'SOUTH')).to eq(true)
    end

    it 'should raise exceptions' do
      expect { @robot.place(nil, nil, 'EAST') }.to raise_error(Exceptions::Command::InvalidCommand)
      expect { @robot.place(1, 'abc', nil) }.to raise_error(Exceptions::Command::InvalidCommand)
      expect { @robot.place(1, 0, 'northeast') }.to raise_error(Exceptions::Command::InvalidCommand)
    end
  end

  context "#move" do
    it 'move in the tabletop' do
      @robot.place(0, 0, 'NORTH')

      expect(@robot.move).to eq( {x:0, y:1})
      expect(@robot.position[:x]).to eq(0)
      expect(@robot.position[:y]).to eq(1)
      expect(@robot.facing).to eq('NORTH')

      @robot.place(1, 2, 'EAST')
      @robot.move
      @robot.move
      @robot.turn_left
      @robot.move

      expect(@robot.position[:x]).to eq(3)
      expect(@robot.position[:y]).to eq(3)
      expect(@robot.facing).to eq('NORTH')
    end

    it 'ignore invalid move' do
      @robot.place(0, 0, 'SOUTH')

      expect{ (@robot.move) }.to raise_error(Exceptions::Tabletop::OutOfTabletop)
      expect(@robot.position[:x]).to eq(0)
      expect(@robot.position[:y]).to eq(0)
      expect(@robot.facing).to eq('SOUTH')
    end
  end

  context "#turn_right" do
    it 'should turn on its right' do
      @robot.place(0, 0, 'NORTH')
      @robot.turn_right
      expect(@robot.facing).to eq('EAST')
      @robot.turn_right
      expect(@robot.facing).to eq('SOUTH')
      @robot.turn_right
      expect(@robot.facing).to eq('WEST')
      @robot.turn_right
      expect(@robot.facing).to eq('NORTH')
      @robot.turn_right
      expect(@robot.facing).to eq('EAST')
    end
  end

  context "#turn_left" do
    it 'should turn on its left' do
      @robot.place(0, 0, 'NORTH')
      @robot.turn_left
      expect(@robot.facing).to eq('WEST')
      @robot.turn_left
      expect(@robot.facing).to eq('SOUTH')
      @robot.turn_left
      expect(@robot.facing).to eq('EAST')
      @robot.turn_left
      expect(@robot.facing).to eq('NORTH')
      @robot.turn_left
      expect(@robot.facing).to eq('WEST')
    end
  end

  context "#report" do
    it 'should report its position' do
      @robot.place(4, 4, 'EAST')
      expect(STDOUT).to receive(:puts).with('4, 4, EAST')
      @robot.report
      @robot.turn_right
      @robot.move
      expect(STDOUT).to receive(:puts).with('4, 3, SOUTH')
      @robot.report
    end  
  end
end