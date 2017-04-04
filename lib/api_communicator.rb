require 'rest-client'
require 'json'
require 'pry'

def get_character_hash_page(url)
  page_of_characters = RestClient.get(url)
  JSON.parse(page_of_characters)
end

def get_character_movies_from_api(character)
  #make the web request
  character_hash_page = get_character_hash_page('http://www.swapi.co/api/people/')
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  character_film_urls = []
  while character_film_urls == []
    character_hash_page["results"].each do |character_info|
      if character_info["name"] == character
        character_film_urls = character_info["films"]
      end
    end
    character_hash_page = get_character_hash_page(character_hash_page["next"])
  end
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  character_film_urls.collect do |url|
    JSON.parse(RestClient.get(url))
  end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

binding.pry

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
