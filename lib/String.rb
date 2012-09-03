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
end
