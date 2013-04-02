require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3::memory:')

class Useragent
  include DataMapper::Resource
    property :id, Serial 
    property :useragent, String
    property :created_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
  Useragent.create(:useragent => request.user_agent, :created_at => Time.now)
  @useragents = Useragent.all(:fields => [:useragent], :unique => true, :order => [:created_at.desc])
  
  haml :index
end
