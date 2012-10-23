# Assorted functions for nathanfeaver.com

############### CATEGORY Functions #####################
# Get all category level items
def categories
  Categories.find :all
end

# Get all category level items with sidebar denotation
def sidebar_categories
  Categories.find :sidebar
end

# Get items from a particular category
def items_of category
  Categories.find :items_of => category
end

# Return the category if it is one, false otherwise
def category? item
  Categories.include? item
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
  item.render
end

############### GET Nanoc::Item Functions #####################

def get_item_by_id test_id
  @items.find {|i| i.identifier == test_id }
end

def get_category_by_id identifier
  #Categories.find :category => identifier
  item = get_item_by_id identifier
  #return ((category? item) ? item : get_category_of(item))
  Categories.find :category_of => item
end

def get_category_of item
  Categories.find :category_of => item
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

