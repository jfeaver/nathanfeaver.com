module Nanoc
  class Item
    def to_sym
      # Examples for an item, item:
      #
      # item.identifier   #=> /blog/
      # item.to_sym       #=> :blog
      #
      # item.identifier   #=> /blog/post_with_spaces/
      # item.to_sym       #=> :"blog/post_with_spaces"
      # 

      if self.identifier == '/'
        :root
      else
        match = self.identifier.match(/^\/(.+)\/$/)
        match[0] ? match[0].to_sym : nil
      end
    end

    def render
      self.reps.find {|rep| rep.name == :default }.compiled_content
    end

  end
end
