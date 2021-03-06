require_relative('../db/sql_runner')

class Album

  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ('#{@title}', '#{@genre}', #{@artist_id}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run( sql )
    albums.map { |album| Album.new(album) }
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = #{@artist_id};"
    artist = SqlRunner.run( sql )[0]
    Artist.new(artist)
  end


end