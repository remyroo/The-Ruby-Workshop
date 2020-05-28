# frozen_string_literal: true

module ApiWrapper
  def send_message(from, to, message)
    puts "Hi #{to}, #{from} wants to say #{message}"
  end

  def new_post(from, title, description)
    puts "This is a post from #{from}, with title: #{title} and #{description}"
  end
end

class Facebook
  extend ApiWrapper
  # by extending it, we make its methods available as class methods
end

Facebook.send_message('Packt', 'Students', 'thank you!')
Facebook.new_post('Author', 'Extending your classes', 'Extend imports functions from modules as class methods!')
