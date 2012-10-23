module Nathan::Classes
  Categories = Class.new
  class << Categories
    # This is an eigenclass built to access meta data about categories.  For example,
    # the following command should return all categories that were found:
    #
    # Categories.find :all
    # 

    # Eigenclasses aren't automatically initialized.  This method must be called before Category is usable
    def initialize items
      build_accessor items
      @initialized = true
    end

    def find args
      raise RuntimeError, "Category lists not initialized, use Category.initialize first" unless @initialized
      case args
      when :all
        return accessor.all
      else
        raise ArgumentError, "Unknown arguments #{args}"
      end
    end

    private

    def build_accessor items
      @accessor = CategoryBuilder.new items
    end

    def accessor
      @accessor
    end

    def accessor= instance
      @accessor = instance
    end

  end
  
end
