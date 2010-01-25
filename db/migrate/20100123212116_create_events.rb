class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.text :description, :null => false
      t.datetime :start_moment, :null => false
      t.datetime :stop_moment, :null => false
      t.decimal :place_latitude
      t.decimal :place_longitude
    end
  end

  def self.down
    drop_table :events
  end
end
