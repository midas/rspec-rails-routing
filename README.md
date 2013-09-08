# RspecRailsRouting

RSpec matchers for Rails routing.


## Installation

Add this line to your application's Gemfile:

    gem 'rspec-rails-routing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-rails-routing


## Usage

Create a routing spec helper.  In this file you will define at least a host.  You can
add an addition level of indirection in order to have multiple hosts.  This is useful
when subdomains are used in your application and must be speced for different routing.

    # spec/support/routing_spec_helper.rb
    module RoutingSpecHelper

      module Hosts

        def host
          some_application_host
        end

        def some_application_host
          'http://www.some-application.test'
        end

      end

    end

    RSpec.configure do |config|
      config.include RoutingSpecHelper::Hosts, :type => :routing
    end

Write a routing spec.

    # spec/routing/projects_routing_spec.rb
    require 'spec_helper'

    describe 'projects routing' do

      let :args do
        ['projects', { :host => host }]
      end

      describe 'path recognition' do

        it { should recognize_restful_index_path( *args ) }
        it { should recognize_restful_show_path( *args ) }
        it { should recognize_restful_new_path( *args ) }
        it { should recognize_restful_edit_path( *args ) }
        it { should recognize_restful_create_path( *args ) }
        it { should recognize_restful_update_path( *args ) }

        it { should_not recognize_restful_destory_path( *args ) }

      end

      describe 'path helpers' do

        # using an open struct here as ActiveRecord models do not have an ID until saved to DB
        let :project do
          OpenStruct.new( id: 1 )
        end

        it { should have_named_route( :projects, "/projects" ) }
        it { should have_named_route( :project, project, "/projects/#{project.id}" ) }
        it { should have_named_route( :new_project, "/projects/new" ) }
        it { should have_named_route( :edit_project, project, "/projects/#{project.id}/edit" ) }
        
        # The create and update actions do not have path helpers as the paths are just the 
        # index and show paths with different HTTP Verbs.

      end

    end

Given the routes file.

    # config/routes.rb
    SomeApplication::Application.routes.draw do
      resources :projects, :except => [:destroy]
    end

The preceding spec will pass.
