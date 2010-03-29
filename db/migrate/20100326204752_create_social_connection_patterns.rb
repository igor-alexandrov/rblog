class CreateSocialConnectionPatterns < ActiveRecord::Migration
  def self.up
    create_table :social_connection_patterns do |t|
      t.string :name, :null => false
      t.string :prefix
      t.string :suffix
      t.timestamps
    end
    
    add_index :social_connection_patterns, :name, :unique => true
  end

  def self.down
    remove_index :social_connection_patterns, :name
    drop_table :social_connection_patterns
  end
end
