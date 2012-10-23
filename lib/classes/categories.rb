module Nathan::Classes
  Categories = Class.new
  class << Categories
    # This is an eigenclass built to access meta data about categories.  For example,
    # the following command should return all categories that were found:
    #
    # Categories.find :all
    #
    # TODO: Add docs
    # 

    # Remember this must be manually called (it's a class method)
    def initialize items
      build_accessor items
      @initialized = true
    end

    def find args
      categories = 
        case args
        when :all
          accessor.all
        when :sidebar
          accessor.sidebar
        else
          if args[:category_of]
            item = args[:category_of]
            accessor.category_of item
          elsif args[:items_of]
            category = args[:items_of]
            accessor.items_of[category.to_sym]
          else
            raise ArgumentError, "Unknown arguments for Category.find: #{args}"
          end
        end
    end

    def include? category
      accessor.all.include? category
    end

    private

    def initialized?
      @initialized || @initializing
    end

    def build_accessor items
      @initializing = true
      @accessor = CategoryBuilder.new items
    end

    def accessor
      initialized? ? @accessor : raise( RuntimeError, "Category lists not initialized, use Categories.initialize first" )
    end

  end
  
end
