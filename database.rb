require 'pg'

$db = PG.connect(ENV['DATABASE_URL'])

# Ensure our tasks table exits
$db.exec('CREATE TABLE IF NOT EXISTS tasks
(
id SERIAL,
title TEXT NOT NULL,
completed BOOL NOT NULL DEFAULT FALSE,
"order" INT NOT NULL DEFAULT 0,
CONSTRAINT tasks_pkey PRIMARY KEY (id)
)')

