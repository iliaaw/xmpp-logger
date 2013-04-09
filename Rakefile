require 'rubygems'
require 'bundler'
require 'sinatra/activerecord/rake'
require 'thinking_sphinx/tasks'

Bundler.require

task :environment do
  Sinatra::Application.environment = ENV['RACK_ENV']
end

require './app'