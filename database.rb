require 'sequel'

if ENV['RACK_ENV'] == 'production'
  DB = Sequel.connect(ENV['DATABASE_URL'])
else
  DB = Sequel.postgres('todo_backend_sinatra_postrgres', :host => 'localhost')
end

# Ensure our tasks table exits
DB.run('CREATE TABLE IF NOT EXISTS tasks
(
id SERIAL,
title TEXT NOT NULL,
completed BOOL NOT NULL DEFAULT FALSE,
"order" INT NOT NULL DEFAULT 0,
CONSTRAINT tasks_pkey PRIMARY KEY (id)
)')

TaskDataset = DB[:tasks]

