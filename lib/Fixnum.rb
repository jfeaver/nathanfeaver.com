class Integer
  def ordinalize
    num = self.modulo 10
    str = num.to_s
    str << case num
    when 1; 'st'
    when 2; 'nd'
    when 3; 'rd'
    else; 'th'
    end
  end
end
