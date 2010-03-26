class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :permalink
      t.string :title
      t.text :description
      t.boolean :enabled
      t.integer :posts_count

      t.timestamps
    end

    add_index :categories, :permalink
    add_index :categories, :enabled

  end

  def self.down
    remove_index :categories, :permalink
    remove_index :categories, :enabled
    
    drop_table :categories
  end
end
