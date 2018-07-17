require 'rest-client'
require 'json'
require 'pry'



def get_all_characters
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_hash["results"]
end

def get_character_info (character)
  get_all_characters.find do |person_hash|
    person_hash["name"].downcase == character
  end
end

def get_character_movies_from_api(character)
  #make the web request
  
  film_info = []
  character_info = get_character_info(character)
  
  character_info["films"].collect do |url|
    response = RestClient.get(url)
    film_info.push(JSON.parse(response))
  end
  film_info
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film_hash|
    puts "#{film_hash["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

