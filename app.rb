require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'sqlite3::memory:')

ActiveRecord::Schema.define do
  create_table :useragents do |t|
    t.column :useragent, :text
    t.column :last_accessed, :datetime
  end
end

class Useragent < ActiveRecord::Base
end

get '/' do
  logger.info "Got a request from #{request.user_agent}" 
  ua = Useragent.find_or_create_by_useragent(request.user_agent)
  ua.last_accessed = DateTime.now

  if not ua.save
    logger.warn "Useragent wasn't saved."
    logger.warn ua.errors.inspect
  end

  @useragents = Useragent.order("last_accessed DESC")

  haml :index
end
