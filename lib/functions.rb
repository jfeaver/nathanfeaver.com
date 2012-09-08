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

# Return the category if it is one, false otherwise
def category? item
  return (item.identifier.match(/^\/\w+\/$/) ? item : false)
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
  "<img src='#{get_rating_image_path rating}' />"
end

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
  tag += item[:landscape] ? 'width=' : 'height'
  tag += "'175px' />"
end

def update hash
  template = "<h4>#{hash[:title]}</h4>\n"
  template += "<span class='date'>Added: #{Date.parse(hash[:date]).strftime('%b. %d, %Y')}</span>\n" unless hash[:first]
  template
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

############### GET Nanoc::Item Attributes Functions #####################

def keywords? item
  return true if item[:keywords] && item[:keywords].reject_nil
  return true if item[:techs] && item[:techs].reject_nil
end

def get_keywords item
  return '' unless keywords? item
  keywords = []
  keywords << (get_category_of item)[:title]
  keywords << item[:keywords] if item[:keywords] && item[:keywords].reject_nil
  keywords << item[:techs] if item[:techs] && item[:techs].reject_nil
  keywords.join(', ')
end
