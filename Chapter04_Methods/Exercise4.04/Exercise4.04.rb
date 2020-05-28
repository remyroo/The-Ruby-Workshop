# frozen_string_literal: true

# Time is a class in the Core Library
# It's a class instead of a module because Time constantly changes
# So Time class allows creation of Time instances that represent a particular state of Time.

Time.class
Time.now
Time.now.class

t = Time.now
t.hour
t.min
t.min

t1 = Time.now
t2 = Time.now
t1 + t2 # raises error, can't add two time instances together
t1 + 7
t2 - t1 # returns difference in time
