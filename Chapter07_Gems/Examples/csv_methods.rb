# frozen_string_literal: true

require 'CSV'

# .read loads the whole file into memory at once
users = CSV.read('users.csv')
users.each do |user|
  puts "name: #{user[0]}"
  puts "age: #{user[1]}"
  puts "city: #{user[2]}"
end
# more performant with .foreach
CSV.foreach('users.csv') do |user|
  puts "name: #{user[0]}"
  puts "age: #{user[1]}"
  puts "city: #{user[2]}"
end

# Passing in the headers option creates a CSV::Table object
# allowing us to search by header name instead of index position
# and to use the CSV::Row method .by_col

users = CSV.read('users_with_headers.csv', headers: true)
users.by_col['name']
users.each do |user|
  puts "name: #{user['name']}"
  puts "age: #{user['age']}"
  puts "city: #{user['city']}"
end

# foreach always returns an Enumerator, even with the headers option
# so it will not respond to the by_col method
CSV.foreach('users_with_headers.csv', headers: true) do |user|
  puts "name: #{user['name']}"
  puts "age: #{user['age']}"
  puts "city: #{user['city']}"
end

# Writing to CSV

CSV.open('new_users.csv', 'w') do |csv|
  csv << ['Sarah Meyer', '25', 'Cologne']
  csv << ['Matt Hall', '35', 'Sydney']
  csv.puts ['James Shaw', '30', 'Oz']
end

# write from enumerable
cities = [
  { name: 'San Francisco', country: 'United States', employees: 15 },
  { name: 'Sydney', country: 'Australia', employees: 11 },
  { name: 'London', country: 'England', employees: 18 }
]

CSV.open('employee_count.csv', 'w') do |csv|
  cities.each do |city|
    csv.puts [city[:name], city[:country], city[:employees]]
  end
end
