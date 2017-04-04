def welcome
  puts "Welcome to Star Wars characters where you can seach all the characters like!"
end

def get_character_from_user
  puts "please enter a character"
  gets.chomp
  # use gets to capture the user's input. This method should return that input, downcased.
end

def get_movie_from_user
  puts "please enter a movie"
  gets.chomp
end
