module RBlog
  module Customization
    #Class holds currently active Identity of RBlog.
    #    
    #@example How to load stylesheets.
    #<%= stylesheet_link_tag ActiveIdentity.stylesheet('master') %>
    #   
    #@example How to load javascripts.
    #<%= javascript_include_tag ActiveIdentiy.javascript('application') %>
    class ActiveIdentity      
      @@identity_name = nil
      cattr_accessor :identity_name
      
      def self.identity_name= (identity_name)
        @@identity_name = identity_name
        ActionController::Base.class_eval do
          #Delete all paths, that are not default
          self.view_paths.size > 1 ? self.view_paths.delete_at(-1) : true
          #Prepend view paths with path for current Identity
          self.prepend_view_path("#{RAILS_ROOT}/app/identities/#{@@identity_name}/views")
        end
      end

      #Loads full Identity as object.
      #Use it only if you want to do something with Identity, for example to show it's parameters.
      #
      #@return [Identity] Identity that is currently activated;
      def self.current
        Theme.load_by_name(self.identity)
      end

      #Get the path of layout file for current Identity by name.
      #If current Identity doesn't have such file, get path of default file.
      #
      #@param [String] name name of requested layout;
      #@return [String] path to requestred layout;
      def self.layout(name)
        if has?(:layout, name)
          File.join(Identity.identities_root, self.identity_name, "/views/layouts/", name + ".html.erb")
        else
          name
        end
      end

      def self.view(name)
        if has?(:view, name)
          File.join(Identity.identities_root, self.identity_name, "/views/", name + ".html.erb")
        else
          name
        end
      end

      #Get the path of stylesheet file for current Identity by name.
      #If current Identity doesn't have such file, get path of default file.
      #
      #@param [String] name name of requested stylesheet;
      #@return [String] path to requestred stylesheet;
      def self.stylesheet(name)
        self.identity_name.nil? ? name : File.join("/identities", self.identity_name, "stylesheets", name + '.css')
      end

      def self.image(name)
        self.identity_name.nil? ? name : File.join("/identities", self.identity_name, "images", name )
      end

      def self.javascript(name)
        self.identity_name.nil? ? name : File.join("/identities", self.identity_name, "javascripts", name + '.js' )
      end

      private
      def self.has?(type, object_name)
        case type
        when :layout
          File.file? File.join(Identity.identities_root, self.identity_name, "/views/layouts/", object_name + '.html.erb')

        when :view
          File.file? File.join(Identity.identities_root, self.identity_name, "/views/", object_name + '.html.erb')
          #        when :stylesheet
          #          File.file? File.join(RAILS_ROOT, "public/stylesheets/themes", self.identity_name, object_name + '.css')
        end
      end
    end
  end
end