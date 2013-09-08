module RspecRailsRouting
  module Matchers
    module Helpers

      def router
        Rails.application.routes
      end

      def extract_info( action, args )
        options = args.extract_options!
        domain  = args.pop

        url_part = args.map do |p|
          if p.is_a?( Symbol )
            p.to_s
          elsif p.is_a?( String )
            "#{p}/1"
          end
        end.join( '/' )

        url_template_part = args.map do |p|
          if p.is_a?( Symbol )
            p.to_s
          elsif p.is_a?( String )
            "#{p}/:#{p.singularize.foreign_key}"
          end
        end.join( '/' )

        namespaces = args.select { |p| p.is_a?( Symbol ) }
        args.shift( namespaces.size )

        nesting_params = Hash[*args.map { |p| [p.singularize.foreign_key.to_sym, '1'] }.flatten]

        if %w(show edit update destroy).include?( action.to_s )
          nesting_params.merge! :id => '1'
        end

        url_end = case action.to_sym
                    when :index, :create
                      ''
                    when :show, :update, :destroy
                      '1'
                    when :new
                      'new'
                    when :edit
                      '1/edit'
                  end

        url_template_end = case action.to_sym
                             when :index, :create
                               ''
                             when :show, :update, :destroy
                               ':id'
                             when :new
                               'new'
                             when :edit
                               ':id/edit'
                           end

        path          = [url_part, domain, url_end].reject( &:blank? ).join( '/' )
        path_template = [url_template_part, domain, url_template_end].reject( &:blank? ).join( '/' )
        url           = "#{options[:host]}/" + path
        controller    = [namespaces, domain].reject( &:blank? ).join( '/' )

        return url, path, path_template, controller, nesting_params
      end

      def format_url_or_path( url_or_path )
        is_url = !url_or_path.match( /^http/ ).nil?
        has_slash = !url_or_path.match( /^\\/ ).nil?
        needs_slash = !is_url && !has_slash

        "#{needs_slash ? '/' : ''}#{url_or_path}".gsub( /\/1/, '/:id' )
      end

      def description_for( action, path_template, controller )
        "route the RESTful #{action} path #{http_verb_for( action ).to_s.upcase} #{format_url_or_path( path_template )} to #{controller}##{action}"
      end

      def failure_message_for_should_for( action, url )
        "failed to recognize the RESTful #{action} path #{http_verb_for( action ).to_s.upcase} #{url}"
      end

      def failure_message_for_should_not_for( action, url )
        "recognized the RESTful #{action} path #{http_verb_for( action ).to_s.upcase} #{url}, but should not"
      end

      def http_verb_for( action )
        case action.to_sym
          when :index, :show, :new, :edit
            :get
          when :create
            :post
          when :update
            :put
          when :destroy
            :delete
        end
      end

    end
  end
end
