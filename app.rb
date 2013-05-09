require 'sinatra/base'
require 'yaml'
require 'active_record'
require 'will_paginate'
require 'will_paginate/active_record'
require 'digest'
require 'thinking_sphinx'
require 'bcrypt'
require './app/models/user'
require './app/models/message'
require './config/initializers/will_paginate'
require './app/controllers/users'
require './app/controllers/messages'
require './app/controllers/search'
require './app/controllers/errors'
require './app/helpers/users'
require './app/helpers/messages'

class App < Sinatra::Base
  set :raise_errors, false
  set :show_exceptions, true if development?
  set :haml, { :ugly => true } if production?
  set :views, File.join(File.dirname(__FILE__), 'app', 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'public')

  env = ENV['RACK_ENV'] || 'development'
  db_config = YAML::load_file(File.join(File.dirname(__FILE__), 'config', 'database.yml'))[env]
  ActiveRecord::Base.establish_connection(db_config)

  register WillPaginate::Sinatra
end
