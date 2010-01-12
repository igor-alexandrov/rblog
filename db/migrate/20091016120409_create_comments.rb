class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :post
      t.references :parent_comment
      t.string :commenter_name, :null => false
      t.string :commenter_email, :null => false
      t.text :body, :null => false
      t.references :author
      
      t.timestamps

    end
    comment = Comment.new do |c|
      c.id = 0
      c.post_id = nil
      c.parent_comment_id = nil
      c.commenter_name = 'rblog developer'
      c.commenter_email = 'igor.alexandrov@gmail.com'
      c.body = 'This comment is here to provide tree comment model. All other top level comments will have parent_comment_id = 0'
    end

    comment.save
  end

  def self.down
    drop_table :comments
  end
end
