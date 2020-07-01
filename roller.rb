# frozen_string_literal: true

class UserLister
  def initialize(users)
    @users = users
  end

  def perform
    @users.each_with_index do |user, index|
      puts "User #{index}: #{user}"
    end
  end
end
