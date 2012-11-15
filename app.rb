require "bundler/setup"
require 'sinatra'
require 'haml'

HISTORY_FILE = 'history.marshal'
HISTORY_COUNT = 50

get '/' do
  @useragent = request.user_agent
  
  if File.exists? HISTORY_FILE then
    @useragents = File.open(HISTORY_FILE) { |f| Marshal.load(f) }
  
    # Remove any old occurences because duplicates look ugly
    @useragents.delete(@useragent)
  
    # Push the just used user agent string to the top of the pile
    @useragents.push(@useragent)
  else
    @useragents = [@useragent]
  end

  File.open(HISTORY_FILE, "w") do |f| 
    Marshal.dump(@useragents.last(HISTORY_COUNT), f)
  end

  haml :index
end

__END__

@@ index
%html
  %h1= @useragent
  %ul
    - @useragents.reverse.each do |useragent|
      %li= useragent
  %a{href: 'https://github.com/jakspalding/ualist'} What is this?