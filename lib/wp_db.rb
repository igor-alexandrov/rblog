class WpDb < ActiveRecord::Base
  establish_connection :wp_db
  self.abstract_class = true
end