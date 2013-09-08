require 'rspec/core'

RSpec.configure do |config|

  config.include RspecRailsRouting::Matchers::Routing, :type => :routing

end
