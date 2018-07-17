require 'rest-client'
require 'json'
require 'pry'

#input: nothing
#output: a hash of all the characters' info
def get_all_characters
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_hash["results"]
end

#input: nothing
#output: a hash of each movie's info
def get_all_movies
  all_movies = RestClient.get('http://www.swapi.co/api/films')
  movie_hash = JSON.parse(all_movies)

  movie_hash["results"]
end

#input: string movie name
#output: a hash of a movie's info
def get_movie_info (movie)
  movie_info = get_all_movies.find do |movie_hash|
    movie_hash["title"].downcase == movie
  end

  puts "#{movie_info}"
end

#input: string character name
#output: a hash of a character's info
def get_character_info (character)
  get_all_characters.find do |person_hash|
    person_hash["name"].downcase == character
  end
end

#input: string character name
#output: hash of film info

def get_character_movies_from_api(character)
  character_info = get_character_info(character)
  
  unless character_info == nil
    character_info["films"].collect do |url|
      response = RestClient.get(url)
      JSON.parse(response)
    end
  end
end

#input: hash of movie info
#output: hash of movie info 
#description: list of character's movie titles is printed to console

def parse_character_movies(films_hash)
  films_hash.each do |film_hash|
    puts "#{film_hash["title"]}"
  end
end

#input: string character name
#output: output of helper functions
def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  unless films_hash == nil
    parse_character_movies(films_hash)
  end
end





title : A New Hope

vehicles : "title or name" (https://www.swapi.co/api/vehicles/4/)