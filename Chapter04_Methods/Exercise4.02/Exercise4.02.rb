# frozen_string_literal: true

def get_data(url, headers = {}, *params)
  puts "Calling #{url}"

  if !headers.empty?
    puts "Headers: #{headers}"
  else
    puts 'No headers'
  end
  params.each do |param|
    puts "Found param: #{param}"
  end
end

def assemble_params(include_headers = true, include_date_in_search = false, only_show_my_records = true)
  headers = { accept: 'application/json' }
  url = 'https://exampleapi.com'
  args = [url]
  header_info = include_headers ? headers : {}
  args << header_info

  params = []
  params << "date=#{Time.now}" if include_date_in_search
  params << 'myrecords=true' if only_show_my_records

  args << params unless params.empty?
end

# The splat operator will disassemble the array produced by assemble_params into
# the individual variables required by get_data signature (url, headers, params).
# When passing in an array of params, they behave the same as positional arguments. Order matters!
get_data(*assemble_params)
get_data(*assemble_params(true))
get_data(*assemble_params(false, true, false))
