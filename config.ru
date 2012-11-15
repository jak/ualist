require 'rubygems'
require "bundler/setup"
require 'sinatra'

set :env,  :production
disable :run

require 'app.rb'

run Sinatra::Application