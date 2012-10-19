module Nathan::Keywords
  
  def keywords? item
    return true if item[:keywords] && item[:keywords].reject_nil
    return true if item[:techs] && item[:techs].reject_nil
    false
  end

  def get_keywords item
    return '' unless keywords? item
    keywords = []
    keywords << (get_category_of item)[:title]
    keywords << item[:title]
    keywords << item[:keywords] if item[:keywords] && item[:keywords].reject_nil
    keywords << item[:techs] if item[:techs] && item[:techs].reject_nil
    keywords.join(', ')
  end

end
