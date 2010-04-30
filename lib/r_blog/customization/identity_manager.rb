module RBlog
  module Customization
    #The Identity manager class hold different operations with Identity object.
    class IdentityManager
      include RBlog::Customization::Errors
      module Log
        def self.identity_valid(identity_name)
          Rails.logger.info "Identity '#{identity_name}'" + "\t\t\t\t\t[VALID]".foreground(:green)
          puts "Identity '#{identity_name}'" + "\t\t\t\t\t[VALID]".foreground(:green)
        end

        def self.identity_invalid(identity_name)
          Rails.logger.error "Identity '#{identity_name}'" + "\t\t\t\t\t[INVALID]".foreground(:red)
          puts "Identity '#{identity_name}'" + "\t\t\t\t\t[INVALID]".foreground(:red)
        end
      end

      def self.install

      end

      def self.uninstall

      end

      def self.validate(identity_name)
        unless self.validate_existance_of_path(File.join(Identity.glob_identities_root, identity_name))
          Log.identity_invalid(identity_name)
          raise InvalidIdentity, "Identity '#{identity_name}' is invalid. Path '#{File.join(Identity.glob_identities_root, identity_name)}' doesn't exist"
        end

        unless self.validate_existance_of_path(File.join(Rails.root, "public/identities", identity_name, "stylesheets"))
          Log.identity_invalid(identity_name)
          raise InvalidIdentity, "Identity '#{identity_name}' is invalid. Path '#{File.join(Rails.root, "public/identities", identity_name, "stylesheets")}' doesn't exist"
        end

        unless self.validate_existance_of_path(File.join(Rails.root, "public/identities", identity_name, "images"))
          Log.identity_invalid(identity_name)
          raise InvalidIdentity, "Identity '#{identity_name}' is invalid. Path '#{File.join(Rails.root, "public/identities", identity_name, "images")}' doesn't exist"
        end

        unless File.readable?(File.join(Identity.glob_identities_root, identity_name, 'theme.yml')) &&
            File.readable?(File.join(Identity.glob_identities_root, identity_name, 'description.textile'))
          Log.identity_invalid(identity_name)
          raise InvalidIdentity, "Identity '#{identity_name}' is invalid"
        end
        Log.identity_valid(identity_name)
      end

      private
      def self.validate_existance_of_path(path)
        Pathname.new(path).exist?
      end
    end
  end
end

