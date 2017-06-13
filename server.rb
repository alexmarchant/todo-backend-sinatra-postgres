require 'sinatra'
require_relative 'controllers/tasks_controller'
require_relative 'database'

set :port, ENV['PORT']

use TasksController
