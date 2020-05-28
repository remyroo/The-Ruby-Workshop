# frozen_string_literal: true

def math_a(array)
  first_item = array.shift
  until array.empty?
    second_item = array.shift
    first_item = yield first_item, second_item
  end
  first_item
end

def math_b(array)
  # process 3 variables at a go
  first_item = array.shift
  until array.empty?
    second_item = array.shift || 0
    third_item = array.shift || 0
    first_item = yield first_item, second_item, third_item
  end
  first_item
end

def math_c(array, arg_count)
  # process x variables at a go
  first_item = array.shift
  until array.empty?
    items = array.shift(arg_count - 1)
    first_item = yield(first_item, *items)
    # splat operator expands an array into a list of arguments
  end
  first_item
end

puts '** Math A **'
puts math_a([4, 5]) { |a, b| a + b }
puts math_a([4, 5]) { |a, b| a * b }
puts math_a([4, 5, 6]) { |a, b| a + b }

puts '** Math B **'
puts math_b([4, 5, 6]) { |a, b, c| a + b + c }
puts math_b([4, 5, 6, 7]) { |a, b, c| a + b + c }

puts '** Math C **'
puts math_c([4, 5, 6, 7], 2) { |a, b| a + b }
puts math_c([4, 5, 6, 7], 4) { |a, b, c, d| a + b + c + d }
