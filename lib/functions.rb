# Assorted functions for nathanfeaver.com

############### GET HTML Functions (links and such)  #####################

FEATURED_IMAGE_DIMENSION = '170px'
def get_featured_image item, img_class = ''
  atts = {}
  image_item = featured_image?
  atts[:class] = "#{img_class} featured"
  atts[:class] += ' landscape' if item[:landscape]
  if image_item
    atts[:src] = "/#{image_item.raw_filename.match(/content\/(.+)/)[1]}"
  else
    atts[:src] = "/images/no_image.png"
  end
  if item[:landscape]
    atts[:width] = FEATURED_IMAGE_DIMENSION
  else
    atts[:height] = FEATURED_IMAGE_DIMENSION
  end
  image_tag(atts)
end

def featured_image?
  @items.find {|i| i.identifier == item[:featured_image]}
end

def image_tag attrs = {}
  atts_string = ''
  attrs.each do |att, value|
    str = nil
    str = "#{att}=#{value}"
    atts_string += "#{str} "
  end
  "<img #{atts_string} />"
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

