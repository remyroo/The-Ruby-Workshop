# frozen_string_literal: true

require 'terminal-table'
# this gem pretty prints a table to the terminal

headings = %w[Name City]
users = [
  %w[James Sydney],
  %w[Chris Perth]
]
table = Terminal::Table.new(rows: users, headings: headings)
puts table
