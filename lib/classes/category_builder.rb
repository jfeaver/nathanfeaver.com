module Nathan::Classes
  class CategoryBuilder

    attr_reader :all, :sidebar, :items_of
    
    def initialize items = nil
      @all = []
      @sidebar = []
      @items_of = {}
      
      # Exclude these items
      @excluded = %w(/)
      build :with => items if items
    end

    def build args
      item_loop args[:with]
    end

    def category_of item
      case
      when !item.respond_to?( :identifier )
        item = item[/^\/\w+\//]
        all.find {|c| item == c.identifier}
      when all.include?( item )
        item
      when (item.identifier == '/')
        item
      else
        all.find {|c| item.identifier[/^\/\w+\//] == c.identifier}
      end
    end

    private

    def item_loop items
      items.sort_by! {|item| item.identifier.count '/' }
      
      items.each do |item|

        # Ignore Assets and specified excluded sites
        unless item.binary? || @excluded.include?( item.identifier )

          # Collect Categories
          if item.identifier.match(/^\/\w+\/$/)
            @all << item
            @sidebar << item if item[:sidebar_item]

            # initialize an array for items of this category
            @items_of[item.to_sym] = []
          
          # Or collect Items into Categories
          else
            category = category_of item
            @items_of[category.to_sym] << item if category
          end
        end
      end
    end

  end 

end
