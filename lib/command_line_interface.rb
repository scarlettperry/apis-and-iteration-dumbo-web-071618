def welcome
  puts "Welcome to the Star Wars Info App!"
end 

def get_input_from_user
  puts "please enter a character or movie"
  input = gets.chomp # use gets to capture the user's input. This method should return that input, downcased.
  input.downcase
end
