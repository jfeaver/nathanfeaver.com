module Enumerable
  def attr_sort symbol
    objects = self.sort_by do |object|
      object[symbol]
    end
    symbol == :created_at ? objects.reverse : objects
  end

  def reject_nil
    self.find {|i| i }
  end
end

