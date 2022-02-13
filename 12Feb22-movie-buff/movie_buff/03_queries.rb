def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:id, :title)
    .joins(:actors)
    .where(actors: { name: those_actors })
    .group(:id)
    .having('COUNT(*) = ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .group('TRUNC(yr, -1)')
    .order('AVG(score) DESC')
    .limit(1)
    .pluck('TRUNC(yr, -1)::Integer AS decade')
    .first
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  Actor
    .joins(:movies)
    .where('movies.id IN (:all_movies)', all_movies: 
      Actor
        .select('movies.id')
        .joins(:movies)
        .where(name: name)
        .group('movies.id')
      )
    .where
    .not(name: name)
    .group(:name)
    .pluck(:name)

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .left_outer_joins(:castings)
    .group(:id)
    .having('COUNT(castings.id) = 0')
    .length

end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

  super_wildcard_name = '%' + whazzername.split('').join('%') + '%'

  Movie
    .joins(:actors)
    .where('actors.name iLIKE ?', super_wildcard_name)
    .group(:id)

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
    Actor
      .select('actors.id, actors.name, MAX(movies.yr) - MIN(movies.yr) AS career')
      .joins(:movies)
      .group(:id)
      .order('MAX(movies.yr) - MIN(movies.yr) DESC, actors.name')
      .limit(3)
      

end
