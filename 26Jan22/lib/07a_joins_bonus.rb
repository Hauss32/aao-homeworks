# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT artist
    FROM albums AS a
    JOIN tracks AS t on t.album = a.asin
    WHERE song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT artist
    FROM albums AS a
    JOIN tracks AS t on t.album = a.asin
    WHERE song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT song
    FROM tracks AS t
    JOIN albums AS a ON t.album = a.asin
    WHERE title = 'Blur'
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
    SELECT
      title,
      COUNT(*)
    FROM tracks AS t
    JOIN albums AS a ON t.album = a.asin
    WHERE song LIKE '%Heart%'
    GROUP BY 1
    ORDER BY 2 DESC, 1 ASC
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT DISTINCT song
    FROM tracks AS t
    INNER JOIN albums AS a ON t.song = a.title
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT DISTINCT a1.title
    FROM albums AS a1
    INNER JOIN albums AS a2 ON a1.title = a2.artist
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT 
      song,
      COUNT(*)
    FROM tracks
    GROUP BY 1
    HAVING COUNT(DISTINCT album) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT
      title,
      price,
      COUNT(*)
    FROM tracks AS t
    JOIN albums AS a ON t.album = a.asin
    GROUP BY 1,2
    HAVING (price / COUNT(*)) < 0.50
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums. Select both the album title and the track
  # count, and order by both track count and title (descending).
  execute(<<-SQL)
    SELECT
      title,
      COUNT(*)
    FROM tracks AS t
    JOIN albums AS a ON t.album = a.asin
    GROUP BY 1
    ORDER BY 2 DESC, 1 DESC
    LIMIT 10
  SQL
end

def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  execute(<<-SQL)
    SELECT 
      artist,
      COUNT(DISTINCT asin)
    FROM albums AS a
    JOIN styles AS s ON a.asin = s.album
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.
  execute(<<-SQL)
    SELECT
      style,
      SUM(price) / SUM(num_tracks) AS avg_price_per_track
    FROM (
      SELECT
        asin,
        price,
        style,
        COUNT(*) AS num_tracks
      FROM tracks AS t
      JOIN albums AS a ON t.album = a.asin
      JOIN styles AS s ON a.asin = s.album
      WHERE price IS NOT NULL
      GROUP BY 1,2,3
    ) AS a
    GROUP BY 1
    ORDER BY 2 DESC, 1 ASC
    LIMIT 5
  SQL
end
