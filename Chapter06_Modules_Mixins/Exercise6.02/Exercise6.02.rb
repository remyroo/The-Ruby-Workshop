# frozen_string_literal: true

# rubocop:disable Style/RedundantSelf

module HelperMethods
  def to_hash
    self.instance_variables.each_with_object({}) do |instance_variable, map|
      map[instance_variable] = self.instance_variable_get(instance_variable)
      map
    end
  end
end

class User
  include HelperMethods
  # by including it, we make its methods available as instance methods
  attr_accessor :id, :name, :email
end
u = User.new
u.id = 1
u.name = 'Bob'
u.email = 'bob@example.com'
u.to_hash # returns hash of instance variables.

module HelperMethods
  def to_hash
    # to_hash will now only return the attributes listed in the attributes_for_json class method
    formatted_class_attributes = self.class.attributes_for_json.map { |attr| "@#{attr}".to_sym }

    filtered_instance_variables = self.instance_variables & formatted_class_attributes
    # & returns the set intersection of two arrays, i.e. filter for the elements that exist in both arrays

    filtered_instance_variables.each_with_object({}) do |instance_variable, map|
      map[instance_variable] = self.instance_variable_get(instance_variable)
      map
    end
  end

  module ClassMethods
    def attributes_for_json
      %i[name email]
    end
  end
end

class User
  include HelperMethods
  extend HelperMethods::ClassMethods
  # by extending it, we make its methods available as class methods

  attr_accessor :id, :name, :email
end
u = User.new
u.id = 1
u.name = 'Bob'
u.email = 'bob@example.com'
u.to_hash
