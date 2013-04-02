require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'data_mapper'

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3::memory:')

class Useragent
  include DataMapper::Resource
    property :id, Serial 
    property :useragent, String, :length => 1024
    property :created_at, DateTime, :default => lambda { |r,p| DateTime.now }
end

DataMapper.finalize.auto_upgrade!

get '/' do
  logger.info "Got a request from #{request.user_agent}" 
  ua = Useragent.new(:useragent => request.user_agent)
  
  if not ua.save
    logger.warn "Useragent wasn't saved."
    logger.warn ua.errors.inspect
  end

  @useragents = Useragent.all(:fields => [:useragent], :unique => true, :order => [:created_at.desc])
  
  haml :index
end
