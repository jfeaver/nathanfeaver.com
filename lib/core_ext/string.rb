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

  def excerpt
    if self.length > 24
      self[0..24] + '...'
    else
      self
    end
  end
  
  def linkify
    self.gsub(/[\s\(\)]/, ' ' => '_', '(' => '', ')' => '')
  end

end
