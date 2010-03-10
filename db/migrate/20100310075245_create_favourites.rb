class CreateFavourites < ActiveRecord::Migration
  def self.up
    create_table :favourites do |t|
      t.references :object, :null => false
      t.string :object_type, :null => false
      t.references :user, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :favourites
  end
end
