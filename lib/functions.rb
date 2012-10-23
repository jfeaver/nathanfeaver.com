# Assorted functions for nathanfeaver.com

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

# get_notice takes one argument:
# - :from (optional)(string)(formatted as nanoc identifier)
# This is where you want to get the notice from
# default: '/'
def get_notice args = {}
  args[:from] ||= '/'
  item = get_item_by_id args[:from]
  item[:notice] || false
end

