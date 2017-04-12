class Song

  attr_accessor :name, :album,
  attr_reader :id

  def initialize(attribute = {})
    @id = attribute['id']
    @name = attribute['name']
    @album = attribute['album']
  end

  # When we create a new song with the Song.new method, we do not set that song's id. A song gets an id only when it gets saved into the database (more on inserting songs into the database later). We therefore set the default value of the id argument that the #initialize method takes equal to nil, so that we can create new song instances that *do not have an id value. We'll leave that up to the database to handle later on.

  #To "map" our class to a database table, we will create a table with the same name as our class and give that table column names that match the attr_accessors of our class.

  # <<- SQL SQL is called a heredoc

  #<<- + name of language contained in our multiline statement + the string, on multiple lines + name of language

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.album)

    # (?, ?) are called bound parameters. Bound parameters protect our program from getting confused by SQL injections and special characters.

        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end

  # def self.create(name:, album:)
  # song = Song.new(name, album)
  # song.save
  # song
  # end

  def self.all
    sql = <<-SQL
    SELECT * FROM songs
    SQL
    results = DB[:conn].execute(sql).collect do |song|
       self.new(song)
    end

  end
end

#Here we have an attr_accessor for name and album. In order to "map" this Song class to a songs database table, we need to create our database, then we need to create our songs table.

 # we are not saving Ruby objects in our database. We are going to take the individual attributes of a given instance, in this case a song's name and album, and save those attributes that describe an individual song to the database as one, single row.
