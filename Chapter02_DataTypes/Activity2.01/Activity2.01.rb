# frozen_string_literal: true

def roll_die
  rand(1..6)
end
puts roll_die

def roll_multi_sided_die(sides)
  rand(sides) + 1
end
puts roll_multi_sided_die(6)

def roll(sides, number_of_die = 1)
  roll_array = []
  number_of_die.times do
    roll_value = rand(sides) + 1
    roll_array << roll_value
  end

  total = 0
  roll_array.each do |roll|
    new_total = total + roll
    total = new_total
  end
  total
end

puts 'Rolling a 5 sided die!'
puts roll(5)

puts 'Rolling two 6 sided dice!'
puts roll(6, 2)
