# frozen_string_literal: true

# write a module Enum that will turn any class into an enumerated data type
# step 1: the basic constructor that will instantiate each payment type passed to it
module Enum1
  def self.included(base_class)
    base_class.extend ClassMethods
    base_class.class_eval do
      # class_eval runs the code passed to it
      # in the context of the class that calls it
      # so this is like adding attr_reader directly to PaymentTypes class
      attr_reader :id, :name, :label
    end

    def initialize(id, name, label)
      @id = id
      @name = name
      @label = label
    end
  end

  module ClassMethods; end
end

class PaymentTypes1
  include Enum1

  DATA = [
    [WIRE = 1, :wire, 'Wire'],
    [CHECK = 2, :check, 'Check'],
    [CREDIT = 3, :credit, 'Credit card']
  ].freeze
end
pt = PaymentTypes1.new(1, :wire, 'Wire')
pt.id
pt.name
pt.label
pt = PaymentTypes1.new(nil, :foo, 'Huh?')

# step 2: add an "all" class method that loops over the DATA constants
# instantiates each one and assigns it to a class instance variable "@all"
module Enum2
  def self.included(base_class)
    base_class.extend ClassMethods2
    base_class.class_eval do
      attr_reader :id, :name, :label
    end

    def initialize(id, name, label)
      @id = id
      @name = name
      @label = label
    end
  end

  module ClassMethods2
    def all
      @all ||= begin # memoization
        self::DATA.map { |args| new(*args) }
      end
    end
  end
end

class PaymentTypes2
  include Enum2

  DATA = [
    [WIRE = 1, :wire, 'Wire'],
    [CHECK = 2, :check, 'Check'],
    [CREDIT = 3, :credit, 'Credit card']
  ].freeze
end
PaymentTypes2.all
# [#<PaymentTypes:0x00007fa7fa231848 @id=1, @label="Wire", @name=:wire>,
# <PaymentTypes:0x00007fa7fa2316b8 @id=2, @label="Check", @name=:check>,
# <PaymentTypes:0x00007fa7fa2315a0 @id=3, @label="Credit", @name=:credit>]

# step 3: we can add interogation methods to PaymentTypes to check whether a type
# is_card? etc, but as we add new enum types we don't want to add new interrogation
# methods over again. Instead, we can use method_missing to auto-generate the new methods.
module Enum3
  def self.included(base_class)
    base_class.extend ClassMethods3
    base_class.class_eval do
      attr_reader :id, :name, :label
    end

    def initialize(id, name, label)
      @id = id
      @name = name
      @label = label
    end
  end

  def is_type?(type)
    # determines the type of a payment
    name.to_sym == type.to_sym
  end

  def method_missing(method, *args, &block)
    # checks if the missing method is an interrogation method to a valid payment type
    interrogation_methods = self.class.all.map { |type| "#{type.name}?".to_sym }

    if interrogation_methods.include?(method)
      # if the new method is valid, send it to the comparison method is_type?
      type = method.to_s.gsub('?', '').to_sym
      is_type?(type)
    else
      super
    end
  end

  module ClassMethods3
    def all
      @all ||= begin
        self::DATA.map { |args| new(*args) }
      end
    end
  end
end

class PaymentTypes3
  include Enum3

  DATA = [
    [WIRE = 1, :wire, 'Wire'],
    [CHECK = 2, :check, 'Check'],
    [CREDIT = 3, :credit, 'Credit card'],
    [MPESA = 4, :mpesa, 'M-Pesa']
  ].freeze

  def wire?
    id == WIRE
  end

  def check?
    id == CHECK
  end

  def credit?
    id == CREDIT
  end
end
PaymentTypes3.all[0].wire?
PaymentTypes3.all[0].credit?
PaymentTypes3.all[2].wire?
PaymentTypes3.all[2].credit?
# use method_missing to autogenerate the type checker for mpesa
# without explicitly defining it
PaymentTypes3.all[3].mpesa?
