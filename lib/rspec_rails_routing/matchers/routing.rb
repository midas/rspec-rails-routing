require 'rspec/expectations'

module RspecRailsRouting
  module Matchers
    module Routing

      def have_named_route(name, *args)
        HaveNamedRoute.new(self, name, *args)
      end

      #class HaveNamedRoute
        #def initialize(context, name, *args)
          #@context = context
          #@name = name
          #@path = "#{name}_path"
          #@args = args
          #if ! args.last
            #raise ArgumentError, 'The last argument must be the expected uri'
          #end
          #@expected_uri = args.pop
        #end

        #def description
          #"have a route named #{@name}, where e.g. #{example_call} == #{@expected_uri}"
        #end

        #def matches?(subject)
          #begin
            #@actual_uri = @context.send( "#{@name}_path", *@args )
            #@actual_uri == @expected_uri
          #rescue NoMethodError => ex
            #false
          #end
        #end

        #def failure_message_for_should
          #"expected #{example_call} to equal #{@expected_uri}, but got #{@actual_uri}"
        #end

        #def failure_message_for_should_not
          #"expected #{example_call} to not equal #{@expected_uri}, but it did"
        #end

        #def example_call
          #call = "#{@name}_path"
          #if ! @args.empty?
            #call << "(#{format_args( @args )})"
          #end

          #call
        #end

        #def format_args( args )
          #@args.map do |a|
            #a.is_a?( Hash ) ? a.inspect : a.to_s
          #end.join( ', ' )
        #end

      #end

    end
  end
end
