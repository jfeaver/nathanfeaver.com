module Enumerable
  def attr_sort symbol
    # TODO - if sortable by integers
    self.sort_by do |item|
      item[symbol]
=begin
      if item[symbol].respond_to?(:to_i)
        # Attribute is an integer
        item[symbol].to_i
      else
        # Attribute is a date
        item[symbol]
      end
=end
    end
  end
end

