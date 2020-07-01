# frozen_string_literal: true

# When using .new, the file must
# be closed before it can be accessible
file = File.new('new_file.txt')
file.puts 'Nice file'
file.close
File.truncate('new_file.txt', 2) # erase its contents to at most 2 char long
File.delete('new_file.txt') # delete whole file

# Reading a whole file into memory
# should only be done if the file is small
# otherwise use .open or .foreach
File.read('company.txt')

# .open and .foreach are interchangeable, both
# iterate through each row, more memory efficient
# when working with larger file sizes.
# The end of the block automatically closes the file
# so you don't have to explicitly say File.close
File.open('company.txt').each do |row|
  puts row
end

File.foreach('company.txt') do |row|
  puts row
end

File.open('new.txt', 'w') do |file|
  file.write('Nice file')
  file << 'Cool cool'
end

File.write('new2.txt', 'Nice file') # shorthand
