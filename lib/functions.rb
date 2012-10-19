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
  unless category.respond_to? :identifier
    cat = get_category_by_id category
    (cat.respond_to?( :identifier ) ? (category = cat) : (raise TypeError, 'expecting Nanoc::Item or string identifier'))
  end
  items = @items.select {|item| item.identifier.match( /^#{category.identifier}\w+\/$/ )}
  has_order = items.all? {|item| item[:order]}
  sort_attr = ( has_order ? :order : :created_at )
  items.attr_sort( sort_attr )
end

# Return the category if it is one, false otherwise
def category? item
  return (item.identifier.match(/^\/\w+\/$/) ? item : false)
end

############### GET HTML Functions (links and such)  #####################

def get_featured_image item, img_class = ''
  image_item = @items.find {|i| i.identifier == item[:featured_image]}
  img_class += ' featured'
  img_class += ' landscape' if item[:landscape]
  tag = "<img class='#{img_class}' src='/"
  if image_item
    tag += image_item.raw_filename.match(/content\/(.+)/)[1]
  else
    tag += "images/no_image.png"
  end
  tag += "' "
  tag += item[:landscape] ? 'width=' : 'height='
  tag += "'170px' />"
end

def render_item item
  item.reps.find {|rep| rep.name == :default }.compiled_content
end

############### GET Nanoc::Item Functions #####################

def get_item_by_id test_id
  @items.find {|i| i.identifier == test_id }
end

def get_category_by_id identifier
  item = get_item_by_id identifier
  return ((category? item) ? item : get_category_of(item))
end

def get_category_of item
  return nil unless item.respond_to?( :identifier )
  return item if category? item
  return item if item.identifier == '/'
  return get_category_by_id( item.identifier.match(/^\/\w+\//)[0] )
end

# get_notice takes one argument:
# - :from (optional)(string)(formatted as nanoc identifier)
# This is where you want to get the notice from
# default: '/'
def get_notice args = {}
  args[:from] ||= '/'
  item = get_item_by_id args[:from]
  item[:notice] || false
end

def notice_for_about
  get_notice if @item.identifier == '/about/'
end

############### GET Nanoc::Item Attributes Functions #####################

def keywords? item
  return true if item[:keywords] && item[:keywords].reject_nil
  return true if item[:techs] && item[:techs].reject_nil
end

def get_keywords item
  return '' unless keywords? item
  keywords = []
  keywords << (get_category_of item)[:title]
  keywords << item[:title]
  keywords << item[:keywords] if item[:keywords] && item[:keywords].reject_nil
  keywords << item[:techs] if item[:techs] && item[:techs].reject_nil
  keywords.join(', ')
end
