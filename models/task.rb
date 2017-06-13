class Task
  attr_accessor :id
  attr_accessor :title
  attr_accessor :completed
  attr_accessor :order

  def initialize(params = {})
    # Convert keys to symbols
    params.keys.each do |key|
      params[(key.to_sym rescue key) || key] = params.delete(key)
    end

    @id = params[:id]
    @title = params[:title]
    @completed = params[:completed]
    @order = params[:order]
  end

  def self.all
    TaskDataset.all.map do |task_data|
      Task.new(task_data)
    end
  end

  def self.delete_all
    TaskDataset.delete
  end

  def self.find(id)
    Task.new(TaskDataset.where(id: id).limit(1).first)
  end

  def self.create(params)
    id = TaskDataset.insert(params)
    Task.find(id)
  end

  def update(params)
    params.each { |name, value| instance_variable_set("@#{name}", value) }
    TaskDataset.where(id: @id).update(params)
  end

  def delete
    TaskDataset.where(id: @id).delete
  end

  def to_json(json_generator = nil)
    {
      id: @id,
      title: @title,
      completed: @completed,
      order: @order,
      url: url,
    }.to_json
  end

  def url
    return nil unless @id
    return ROOT_URL + '/tasks/' + @id.to_s
  end
end

