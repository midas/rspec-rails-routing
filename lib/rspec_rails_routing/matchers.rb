require 'rspec/expectations'

module RspecRailsRouting
  module Matchers

    autoload :HaveNamedRoute, 'rspec_rails_routing/matchers/have_named_route'
    autoload :Helpers,        'rspec_rails_routing/matchers/helpers'
    autoload :Routing,        'rspec_rails_routing/matchers/routing'

  end
end

%w(
  index
  show
  new
  edit
  create
  update
  destroy
).each do |action|

  RSpec::Matchers.define :"recognize_restful_#{action}_path" do |*args|

    include RspecRailsRouting::Matchers::Helpers

    url, path, path_template, controller, nesting_params = extract_info( action, args )

    match do |actual|
      begin
        router.recognize_path( url, :method => http_verb_for( action ) ) == {
          :controller => controller,
          :action     => action
        }.merge( nesting_params )
      rescue ActionController::RoutingError => ex
        false
      end
    end

    description do
      description_for action, path_template, controller
    end

    failure_message_for_should do |actual|
      failure_message_for_should_for action, url
    end

    failure_message_for_should_not do |actual|
      failure_message_for_should_not_for action, url
    end

  end
end
