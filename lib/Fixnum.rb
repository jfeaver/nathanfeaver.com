class Integer
  def ordinalize
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
