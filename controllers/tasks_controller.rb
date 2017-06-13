require_relative '../models/task'

class TasksController < Sinatra::Base
  before do
    content_type 'application/json'
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Allow"] = "GET, POST, PATCH, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  end

  get '/' do  
    Task.all.to_json
  end

  delete '/' do  
    Task.delete_all
    200
  end

  post '/' do
    unless task = Task.create(filtered_params)
      return internal_server_error_response
    end

    task.to_json
  end

  get '/tasks/:id' do
    id = params['id'].to_i
    return invalid_id_response if id == 0

    unless task = Task.find(id)
      return not_found_response
    end

    task.to_json
  end

  patch '/tasks/:id' do
    id = params['id'].to_i
    return invalid_id_response if id == 0

    unless task = Task.find(id)
      return not_found_response
    end

    unless task.update(filtered_params)
      return internal_error_response
    end
    
    task.to_json
  end

  delete '/tasks/:id' do
    id = params['id'].to_i
    return invalid_id_response if id == 0

    unless task = Task.find(id)
      return not_found_response
    end

    task.delete
    200
  end

  options "*" do
    200
  end

  private

    def invalid_id_response
      [400, {error: 'Invalid id'}.to_json]
    end

    def not_found_response
      [404, {error: 'Task not found'}.to_json]
    end

    def internal_server_error_response
      [500, {error: 'Internal server error'}.to_json]
    end

    def body_params
      JSON.parse(request.body.read)
    end

    def filtered_params
      body_params.select do |key, value|
        whitelisted_params.include?(key.to_sym)
      end
    end

    def whitelisted_params
      [:title, :completed, :order]
    end
end
