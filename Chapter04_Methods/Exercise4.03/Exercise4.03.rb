# frozen_string_literal: true

# Ruby has a Core Library and a Standard Library
# Math is a module in the Core Library
# Modules are good for methods that never change. sqrt(144) will always be 12.
Math.class

Math.sin(45)

Math.sqrt(144)

x = -10

increment = 0.25

while x < 10
  y = Math.sin(x)

  puts "#{x} #{y}"

  x += increment
end
