# frozen_string_literal: true

class Address
  attr_reader :street_address, :city, :post_code, :country

  def initialize(street_address, city, post_code, _country)
    @street_address = street_address
    @city = city
    @post_code = post_code
  end
end

class UnitedStatesAddress < Address
  attr_reader :state

  def initialize(street_address, city, state, post_code)
    @state = state
    @country = 'UnitedStates'
    super
  end
end

class CanadianAddress < Address
  attr_reader :province

  # alternative option, you can use a hash instead of positional args
  def initialize(opts = {})
    @country = 'Canada'

    street_address = opts[:street_address]
    city = opts[:city]
    province = opts[:province]
    post_code = opts[:post_code]
    super(street_address, city, post_code, country)
  end
end

a = Address.new('25 Martin Luther King Jr Blvd', 'Oakland', '94008')
a.street_address
a.post_code
a.street_address = '5 Broadway'
a.street_address

# this produces an error, when you call super without explicitly passing it's args,
# it implicitly passes the subclass' args as positional args to the superclass.
UnitedStatesAddress.new('1 Broadway', 'New York', 'New York', 10_010)

CanadianAddress.new
