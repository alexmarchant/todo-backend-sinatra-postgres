require 'sinatra'
require_relative 'controllers/tasks_controller'
require_relative 'database'

set :port, ENV['PORT']

options "*" do
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Allow"] = "GET, POST, PATCH, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  200
end

use TasksController
