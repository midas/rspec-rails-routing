require "rspec_rails_routing/version"

module RspecRailsRouting

  autoload :Matchers, 'rspec_rails_routing/matchers'

end

require 'rspec_rails_routing/rspec' if defined?( RSpec )
