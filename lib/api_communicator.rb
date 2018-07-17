require 'rest-client'
require 'json'
require 'pry'
require 'rainbow'

#input: URL
#output: parsed JSON
def get_response_body(element_url)
  response = RestClient.get(element_url)
  JSON.parse(response)
end

#input: nothing
#output: a hash of all the characters' info
def get_all_characters
  get_response_body('http://www.swapi.co/api/people/')["results"]
end

#input: nothing
#output: a hash of each movie's info
def get_all_movies
  get_response_body('http://www.swapi.co/api/films')["results"]
end

#input: string movie name
#output: a hash of a movie's info
def get_movie_info (movie)
  movie_info = get_all_movies.find do |movie_hash|
    movie_hash["title"].downcase == movie
  end
  unless movie_info == nil
    parse_movie_info(movie_info)
  else
    puts "This movie does not exist!"
  end
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
      get_response_body(url)
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

def parse_movie_info(movie_info)
  movie_info.each do |key, value|
    if value.is_a?(Array)
      puts Rainbow("#{key}").underline + ": "
      value.each do |url|
        # binding.pry
        puts "#{what_to_call_it(url)}"
      end
    end
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

#input: Takes in URL of JSON you would like parse
#output: The value of the name or title key in said JSON object
def what_to_call_it(element_url)
  get_response_body(element_url).find do |info, value|
    # binding.pry
    if info == "title" or info == "name"
      puts "\t#{value}"
    end
  end
end



