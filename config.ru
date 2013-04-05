require './app'
use ActiveRecord::ConnectionAdapters::ConnectionManagement
use Rack::Session::Cookie, :expire_after => 2592000, :secret => 'SECRET'
run App