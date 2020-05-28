# frozen_string_literal: true

def play_game
  print "I'm going to pick a random number that you will have to guess. Please enter the maximum number for the guessing range."
  range = gets.chomp.to_i
  magic_number = rand(range)
  until try_guess(magic_number)
  end
end

def try_guess(magic_number)
  print "What's your guess? "
  guess = gets.chomp.to_i
  if guess == magic_number
    puts 'You guessed correctly!'
    true
  elsif guess < magic_number
    puts 'Guess higher'
    false
  else
    puts 'Guess lower'
    false
  end
end

play_choice = 'y'
while play_choice == 'y'
  print 'Welcome to HiLow - Shall we play? [Y/n]'
  play_choice = gets.chomp.downcase
  play_game if play_choice == 'y'
end
puts 'Thanks for playing!'
