# -*- encoding: utf-8 -*-
require 'rspec'

RSpec.configure do |c|
  c.mock_with :rspec
end

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each{ |f| require f }
