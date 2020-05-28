# frozen_string_literal: true

# Model a company's org chart
class User
  attr_accessor :name, :address
  attr_reader :department

  def initialize(name, address, department)
    @name = name
    @address = address
    @department = department
    department.users << self # Assign the user to department on creation
  end

  # Override setter method to keep the department's users up to date
  # when a user changes departments
  def department=(new_department)
    @department.users.delete(self)
    @department = new_department
    @department.users << self
  end
end

class Company
  attr_accessor :name, :url, :departments

  def initialize(name, url)
    @name = name
    @url = URI.parse(url)
  end

  def users
    departments.map(&:users).flatten
  end
end

# code for seeding the users instance variable at object creation
# class Department
#   attr_accessor :name, :users

#   def initialize(name)
#     @name = name
#     @users = []
#   end
# end

# code for seeding the users instance variable at runtime for better performance
# because the array doesn't get saved until users is called, rather than on
# initialization which can save memory if dealing with big data.
class Department
  attr_accessor :name, :users

  def initialize(name)
    @name = name
  end

  def users
    # Override the accessor to make sure we always
    # have an array to work with to avoid nil conditions
    @users ||= []
  end
end

# Setup data
c = Company.new('Acme Inc', 'https://example.com')

engineering = Department.new('Engineering')
sales = Department.new('Sales')

c.departments = [sales, engineering]

bob = User.new('Bob Smith', '1 Main Street', sales)
mary = User.new('Mary Jane', '10 Independence Blvd', engineering)

# Test moving bob from sales to engineering
engineering.users.map(&:name)
bob.department = engineering
engineering.users.map(&:name)
sales.users.map(&:name)
