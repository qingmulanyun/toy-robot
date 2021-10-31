require 'spec_helper'

describe Tabletop do
  context "#initialize" do
    it 'create a new tabletop with valid params' do
      expect(Tabletop.new(5, 5).row).to eq(5)
    end

    it 'raise error with invalid params' do
      expect{Tabletop.new('12t', 5)}.to raise_error.with_message('Invalid value')
    end
  end


  context '#out_of_tabletop?' do
    before { @tabletop = Tabletop.new(5, 5) }

    it 'return false' do
      expect(@tabletop.out_of_tabletop?(2,2)).to be_falsey
    end

    it 'return true' do
      expect(@tabletop.out_of_tabletop?(7,7)).to be_truthy
    end
  end
end