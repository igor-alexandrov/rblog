class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.text :body
      t.text :announcement
    end
  end

  def self.down
  end
end
