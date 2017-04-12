#Before we can create a songs table we need to create our music database.
# Remember, classes are mapped to tables inside a database, not to the database as a whole.

require 'bundler'
Bundler.require

require 'sqlite3'
require_relative '../lib/song.rb'


DB = {:conn => SQLite3::Database.new("db/music.db")}
DB[:conn].results_as_hash = true

#Here we set up a constant, DB, that is equal to a hash that contains our connection to the database. In our lib/song.rb file, we can therefore access the DB constant and the database connection it holds like this:
