module Enumerable
  def attr_sort symbol
    # TODO - if sortable by integers
    self.sort_by {|nanoc_item| nanoc_item[symbol].to_i }
  end
end

