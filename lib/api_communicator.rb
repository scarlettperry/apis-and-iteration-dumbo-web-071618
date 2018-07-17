require 'rest-client'
require 'json'
require 'pry'

def get_all_characters
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_hash["results"]
end

def get_all_movies
  all_movies = RestClient.get('http://www.swapi.co/api/films')
  movie_hash = JSON.parse(all_movies)

  movie_hash["results"]
end

def get_movie_info (movie)
  movie_info = get_all_movies.find do |movie_hash|
    movie_hash["title"].downcase == movie
  end

  puts "#{movie_info}"
end

def get_character_info (character)
  get_all_characters.find do |person_hash|
    person_hash["name"].downcase == character
  end
end



def get_character_movies_from_api(character)
  character_info = get_character_info(character)
  
  unless character_info == nil
    character_info["films"].collect do |url|
      response = RestClient.get(url)
      JSON.parse(response)
    end
  end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film_hash|
    puts "#{film_hash["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  unless films_hash == nil
    parse_character_movies(films_hash)
  end
end