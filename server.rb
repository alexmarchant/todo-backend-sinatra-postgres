require 'sinatra'
require_relative 'controllers/tasks_controller'
require_relative 'database'

set :port, ENV['PORT']
ROOT_URL = ENV['RACK_ENV'] == 'production' ?
  ' https://todo-backend-sinatra-postgres.herokuapp.com' :
  'http://localhost:3000' 

use TasksController
