class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :dotted_ids
      t.references :parent
      t.string :title, :null => false
      t.text :content
      t.string :permalink, :null => false
      t.boolean :is_index, :default => false
      t.timestamps
    end

    add_index :pages, :permalink
    add_index :pages, :parent_id
  end

  def self.down
    remove_index :pages, :permalink
    remove_index :pages, :parent_id
    drop_table :pages
  end
end
