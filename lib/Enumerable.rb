module Enumerable
  def attr_sort symbol
    self.sort_by do |item|
      item[symbol]
    end
  end

  def reject_nil
    self.find {|i| i }
  end
end

