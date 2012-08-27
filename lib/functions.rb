# Assorted functions for nathanfeaver.com

############### CATEGORY Functions #####################

# Get all category level items
def categories
  @items.select {|item| item.identifier.match(/^\/\w+\/$/) }
end

# Get all category level items with sidebar denotation
def sidebar_categories
  s_cat = categories.select {|category| category[:sidebar_item]}.attr_sort( :sidebar_item )
end

# Get items from a particular category
def items_of category
  regex = '/^\/' + category.identifier[1..-1] + '\/\w+\/$/'
  @items.select {|item| item.identifier.match( /^#{category.identifier}\w+\/$/ )}.attr_sort( :created_at )
end


