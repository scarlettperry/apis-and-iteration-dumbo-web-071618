#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

require 'rest-client'
character_data = RestClient.get('http://swapi.co/api/people')


welcome
input = get_input_from_user
 unless show_character_movies(input)
    get_movie_info(input)
 end
