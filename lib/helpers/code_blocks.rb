module Nathan::CodeBlocks

  #prepares html with newline characters for preformatted text
  def safe_newlines html
    html.gsub("\n", "&#x000A;")
  end

  def strip_final_newline html
    html.gsub(/\n\n$/,"\n")
  end

  def code_block item, file, language
    file_path = "#{base_dir}/content/code#{item.identifier}#{file}.#{language}"
    html = CodeRay.scan_file(file_path).html
    html = strip_final_newline(html)
    safe_newlines(html)
  end

end
