usage       'create_command [options]'
aliases     
summary     'Creates a new generic Nanoc command file in nanoc_path/commands'
description ''

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

run do |opts, args, cmd|
  if args.first
    filename = args.first
    puts "Creating the command: $ nanoc '#{filename}'. Stand by..."
    filename += '.rb'
    
    path = "commands/#{filename}"
    template = <<TEMPLATE
usage       'dostuff [options]'
aliases     :ds, :stuff
summary     'does stuff'
description 'This command does a lot of stuff. I really mean a lot.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end
flag   :m, :more,  'do even more stuff'
option :s, :stuff, 'specify stuff to do', :argument => :optional

run do |opts, args, cmd|
  stuff = opts[:stuff] || 'generic stuff'
  puts "Doing \#{stuff}!"

  if opts[:more]
    puts 'Doing it even more!'
  end
end
TEMPLATE
    
    File.open(path, 'w') { |f| f.write(template) }
    puts "\t[ok] Edit #{path}"

  else
    puts "Please include the name of the command.\nUsage: nanoc create_command create_item_for"
    exit 1
  end
end
