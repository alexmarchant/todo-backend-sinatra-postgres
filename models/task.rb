class Task
  attr_accessor :id
  attr_accessor :title
  attr_accessor :completed
  attr_accessor :order

  def self.all
    tasks = []

    $db.exec('SELECT id, title, completed, "order" FROM tasks') do |result|
      result.each do |row|
        tasks << Task.new({
          id: row['id'],
          title: row['title'],
          completed: row['completed'],
          order: row['order'],
        })
      end
    end

    tasks.to_json
  end

  def self.delete_all
  end

  def self.find(id)
    nil
  end

  def self.create(params)
  end

  def initialize(params = {})
    @id = params[:id]
    @title = params[:title]
    @completed = params[:completed]
    @order = params[:order]
  end

  def update(params)
  end

  def delete
  end

  def to_json(json_generator)
    {
      id: @id,
      title: @title,
      completed: @completed,
      order: @order,
      url: @url,
    }.to_json
  end

  def url
    return nil unless @id
    ''
  end
end
