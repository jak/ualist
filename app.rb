require 'sinatra'
require 'haml'

get '/wut' do
  redirect 'https://github.com/jakspalding/ualist'
end

get '/' do
  @useragent = request.user_agent
  @useragents = []
  haml :index
end

__END__

@@ index
%html
  %h1=@useragent
  %ul
  - @useragents.each do |useragent|
    %li= useragent
  %a{:href => url('/wut')} What is this?