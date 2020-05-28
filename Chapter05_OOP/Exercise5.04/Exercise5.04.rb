# frozen_string_literal: true

# rubocop:disable Style/RedundantSelf

class User
  def public_method
    puts 'This is a public method'
  end

  protected

  def protected_method
    puts 'This is a protected method'
  end

  private

  def private_method
    puts 'This is a private method'
  end
end
u = User.new
u.public_method
u.protected_method # raises error
u.private_method # raises error

class User
  def call_each
    public_method # implicit self
    protected_method
    private_method
  end

  def public_method
    puts 'This is a public method'
  end

  protected

  def protected_method
    puts 'This is a protected method'
  end

  private

  def private_method
    puts 'This is a private method'
  end
end
u = User.new
u.call_each
# no errors, protected and private methods are accessible when called
# from within the object scope

class User
  def call_each
    self.public_method # explicit call to self
    self.protected_method
    self.private_method
  end

  def public_method
    puts 'This is a public method'
  end

  protected

  def protected_method
    puts 'This is a protected method'
  end

  private

  def private_method
    puts 'This is a private method'
  end
end
u.call_each
# self.private_method returns an error.
# self is simply a reference to the object, so by using it explicitly
# ruby thinks we're calling the method from outside the class and
# enforces the privacy restrictions.
# protected methods can however be called using the explicit self keyword, but only
# when inside the object instance scope aka an explicit self-invocation.

require 'digest'
class User
  def initialize(email)
    @email = email
  end

  def ==(other)
    self.unique_id == other.unique_id
  end

  protected

  def unique_id
    Digest::MD5.hexdigest @email.downcase
  end
end

u = User.new('test@example.com')
u2 = User.new('foo@example.com')
u3 = User.new('TesT@EXAMPLE.COM')
u == u2 # false
u == u3 # true

# Protected methods can also be called by an object A on another object B,
# as long as B is the same type as A
class Admin < User
end

class Department
  def initialize(name)
    @name = name
  end

  protected

  def unique_id
    Digest::MD5.hexdigest @name.downcase
  end
end
u = User.new('test@example.com')
admin = Admin.new('admin@example.com')
admin2 = Admin.new('test@example.com')
sales = Department.new('sales')

u == admin # false
u == admin2 # true
u == sales # raises error because department is completely separate class from user
# so we can't call it's protected unique_id method from the user class.
