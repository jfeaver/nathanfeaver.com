require 'date'

usage       'create_item_for CATEGORY TITLE'
aliases     :cif
summary     'Creates item inside a category'
description 'This command creates a new Nanoc item for NathanFeaver.com inside /content/{category}/{item}'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

run do |opts, args, cmd|
  if args.length >= 2
    category, title = args
    link = (args[2] ? args[2] : '')
    path_category, path_title = args.collect {|attr| attr.gsub(/\s/,'_').downcase }
    identifier = "/#{path_category}/#{path_title}/"
  else
    puts 'Please include a category and title in your command:'
    puts cmd.usage
    exit 1
  end
  unless File.directory?("#{File.dirname File.dirname( __FILE__ )}/content/#{path_category}")
    puts 'That category does not yet exist. Create that category and try again.'
    exit 1
  end

  path = calc_path(path_title, path_category)

  if File.exists?("#{File.dirname File.dirname( __FILE__ )}/#{path}")
    puts 'That item already exists. Halting creation.'
    exit 1
  end

  extra = ''
  landscape = 'true'
  case path_category
  when 'bookshelf'
    extra = "\nrating: \nauthor: "
    landscape = 'false'
  when 'portfolio'
    extra = "\nlink: #{link}"
  end

  template = <<TEMPLATE
---
title: #{title}
created_at: #{Date.today.to_s}
featured_image: /images#{identifier}
landscape: #{landscape}
techs:
  -
description: 
  - ""#{extra}
---
TODO: Add content to `#{path}`.
TEMPLATE

  File.open(path, 'w') { |f| f.write(template) }
  puts "\t[ok] Edit #{path}"
end

def calc_path(title, category)
  filename = "#{title}.haml"
  path = "content/#{category}/#{filename}"
end
