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
  @items.select {|item| item.identifier.match( /^#{category.identifier}\w+\/$/ )}.attr_sort( :created_at )
end

def category? item
  item.identifier.match(/^\/\w+\/$/)
end
=begin
module Nanoc
  class Item
    def self.category?
      self.identifier.match(/^\/\w+\/$/)
    end
    public :category?
  end
end
=end
############### GET HTML Functions (links and such)  #####################

def get_rating_image_path rating
  path = '/images/ratings/'
  case rating
  when 0
    path += 'double_thumbs_down'
  when 1
    path += 'thumbs_down'
  when 2
    path += 'thumbs_up'
  when 3
    path += 'double_thumbs_up'
  end
  path += '.gif'
end

def get_rating_image rating
  "<img class='rating' src='#{get_rating_image_path rating}' />"
end

def get_featured_image item, img_class = ''
  image_item = @items.find {|i| i.identifier == "/images#{item.identifier}"}
  img_class += ' featured'
  img_class += ' landscape' if item[:landscape]
  tag = "<img class='#{img_class}' src='/"
  if image_item
    tag += image_item.raw_filename.match(/content\/(.+)/)[1]
  else
    tag += "images/no_image.png"
  end
  tag += "' "
  tag += item[:landscape] ? 'width=' : 'height'
  tag += "'175px' />"
end

def update hash
  template = ''
  template += "<h4>#{hash[:title]}</h4>\n<span class='date'>Added: #{Date.parse(hash[:date]).strftime('%b. %d, %Y')}</span>\n" unless hash[:first]
end

############### GET Nanoc::Item Functions #####################

def get_item_by_id identifier
  @items.find {|i| i.identifier == identifier }
end

def get_category_by_id identifier
  get_item_by_id identifier
end

def get_category_of item
  return nil unless item.respond_to?( :identifier )
  return item if category? item
  return false if item.identifier == '/'
  return get_category_by_id( item.identifier.match(/^\/\w+\//)[0] )
end
