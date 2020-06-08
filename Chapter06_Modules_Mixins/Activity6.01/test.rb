# frozen_string_literal: true

ENV['TEST'] = 'true'
require './application'
Dir['./tests/*rb'].sort.each { |f| require f }
