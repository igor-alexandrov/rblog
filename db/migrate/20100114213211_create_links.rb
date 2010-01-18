class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.text :description, :null => false
      t.string :url, :null => false
      t.string :text, :null => false
    end
  end

  def self.down
    drop_table :links
  end
end
