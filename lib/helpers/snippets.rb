
module Nathan::HTMLSnippets
  
  module Bookshelf
    
    def get_rating_image rating
      "<img src='#{get_rating_image_path rating}' />"
    end
   
    private
  
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

  end

  module Blog

    def update hash
      template = "<h4>#{hash[:title]}</h4>\n"
      template += "<span class='date'>Added: #{Date.parse(hash[:date]).strftime('%b. %d, %Y')}</span>\n" unless hash[:first]
      template
    end

    def blog_heading title
      "<a name=#{title.linkify}></a><h4>#{title}</h4>"
    end

    def link_to_hash title, basepath = false
      basepath ||= @item.path
      "<a href='#{basepath}##{title.linkify}'>#{title}</a>"
    end

    # Links to WordPress documentation
    def link_to_wp_function text, function = false
      unless function
        function = text.match(/(\w+)(\(.*\))*/)[1]
      end
      unless function
        raise ArgumentError, "function should not contain spaces: #{function}" if function.include? ' '
        raise ArgumentError, "function is not recognized: #{function}"
      end
      "<a href='http://codex.wordpress.org/Function_Reference/#{function}', target='_blank'><code>#{text}</code></a>"
    end

    # Opens a new tab with the link
    def link_to_tab text, target
      "<a href='#{target}', target='_blank'>#{text}</a>"
    end

  end
  
  include Bookshelf
  include Blog
end

