def welcome
  puts "Welcome to Star Wars characters where you can seach all the characters like!"
end

def get_character_from_user
  puts "please enter a character"
  character = gets
  gets.chomp
  # use gets to capture the user's input. This method should return that input, downcased.
end
