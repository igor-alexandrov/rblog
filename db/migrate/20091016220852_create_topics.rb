class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.text :body, :null => false
      t.text :announcement
    end
  end

  def self.down
    drop_table :topics
  end
end
