class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :post, :null => false
      t.references :parent_comment
      t.string :type, :null => false
      t.text :body, :null => false
      t.string :guest_commenter_name
      t.string :guest_commenter_email
      t.references :author
      t.integer :rating, :default => 0
      t.integer :depth, :null => false, :default => 0
      t.timestamps

    end

    add_index :comments, :parent_comment_id
    add_index :comments, :type
    add_index :comments, :author_id
  end

  def self.down
    remove_index :comments, :parent_comment_id
    remove_index :comments, :type
    remove_index :comments, :author_id

    drop_table :comments
  end
end
