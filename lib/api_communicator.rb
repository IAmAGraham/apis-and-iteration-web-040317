require 'rest-client'
require 'json'
require 'pry'

def get_info_hash_page(url)
  page_of_info = RestClient.get(url)
  JSON.parse(page_of_info)
end

def get_character_film_urls(character)
  character_hash_page = get_info_hash_page('http://www.swapi.co/api/people/')
  character_film_urls = []
  while character_film_urls == []
    character_hash_page["results"].each do |character_info|
      if character_info["name"] == character
        character_film_urls = character_info["films"]
        break
      end
    end
    character_hash_page = get_info_hash_page(character_hash_page["next"])
  end
  character_film_urls
end

def parse_json(json_string)
  json_string.collect do |url|
    JSON.parse(RestClient.get(url))
  end
end

def get_character_movies_from_api(character)
  #make the web request

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  character_film_urls = get_character_film_urls(character)

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  parse_json(character_film_urls)
end

def parse_character_movies(films_hash)
  puts "*" * 30
  puts "These are the movies this character is in:"
  films_hash.each do |film|
    puts "   #{film['title']}"
  end
  puts "*" * 30
end


  # some iteration magic and puts out the movies in a nice list


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

def get_movie_crawl_text(movie)
  puts "*" * 30
  movie_info = get_info_hash_page('http://www.swapi.co/api/films/')
  movie_info["results"].each do |movie_hash|
    if movie_hash["title"] == movie
      puts movie_hash["opening_crawl"]
      break
    end
  end
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
