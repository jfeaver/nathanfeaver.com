module Nathan::Classes
  class CategoryBuilder
    require 'logger'

    attr_reader :all, :sidebar, :items_of
    
    def initialize items = nil
      @all = []
      @sidebar = []
      @items_of = Hash.new([])
      build :with => items if items
    end

    def build args
      item_loop args[:with]
    end

    private

    def nanoc_site_items
      Nathan.instance_eval{ @items }
    end

    def item_loop items
      file = File.new('CategoryBuilder.log', 'w')
      logger = Logger.new(file)
      items.sort_by! {|item| item.identifier.count '/' }
      
      # Remove Root page
      if items.first.identifier == '/'
        items.shift
      end

      items.each do |item|

        # Ignore Assets
        unless item.binary?
          
          # Collect Categories
          if item.identifier.match(/^\/\w+\/$/)
            @all << item
            @sidebar << item if item[:sidebar_item]
          
          # Or collect Items into Categories
          else
            category = item.identifier.match(/^\/(\w+)\//)[0]
            @items_of[category.to_sym] << item
          end
        end
      end
      logger.info('all') { @all.inspect }
      logger.info('sidebar') { @sidebar.inspect }
      logger.info('items_of') { @items_of.inspect }
    end

  end 

end
