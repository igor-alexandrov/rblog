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

      t.timestamps

    end
#    comment = Comment.new do |c|
#      c.id = 0
#      c.post_id = nil
#      c.parent_comment_id = nil
#      c.commenter_name = 'rblog developer'
#      c.commenter_email = 'igor.alexandrov@gmail.com'
#      c.body = 'This comment is here to provide tree comment model. All other top level comments will have parent_comment_id = 0'
#    end

#    comment.save

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
