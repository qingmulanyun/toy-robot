class Tabletop
  attr_reader :row, :col

  def initialize(row, col)
    raise ArgumentError, 'Invalid value' unless (row.is_a? Integer) && (col.is_a? Integer)
    @row = row
    @col = col
  end

  def out_of_tabletop?(x, y)
    !(x >= 0 && x <= col && y >= 0 && y<= row)
  end
end