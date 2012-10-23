class String
  require 'date'

  def parsable_date?
    begin
      Date.parse(self)
    rescue
      return false
    end
  end

  def state_first
    match, city, state = *self.match(/(\w+ *\w+), ([A-Z]{2})/)
    if city && state
      return "#{state}: #{city}"
    else
      return self
    end
  end

  # Excerpt for navigation bar links
  def excerpt
    if self.length > 24
      self[0..24].rstrip + '...'
    else
      self
    end
  end
  
  # Removes spaces and parentheses
  # Used in create_item_for script
  def linkify
    self.gsub(/[\s\(\)]/, ' ' => '_', '(' => '', ')' => '')
  end

  old_to_sym = instance_method(:to_sym)
  
  define_method(:to_sym) do
    if match = self.match(/^\/(\.+)\//)
      old_to_sym.bind(match[1]).call
    else
      old_to_sym.bind(self).call
    end
  end

end
