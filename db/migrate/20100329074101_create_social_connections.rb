class CreateSocialConnections < ActiveRecord::Migration
  def self.up
    create_table :social_connections do |t|
      t.references :user, :null => false
      t.references :pattern, :null => false
      t.string :value, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :social_connections
  end
end
