class Integer
  def ordinalize
    return "#{self}th" if (4..20).include? self.modulo 100
    ordinal = self.to_s
    last_digit = self.modulo 10
    ordinal << case last_digit
    when 1; 'st'
    when 2; 'nd'
    when 3; 'rd'
    else; 'th'
    end
  end
end

