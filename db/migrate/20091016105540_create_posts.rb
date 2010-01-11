class CreatePosts < ActiveRecord::Migration
    def self.up
        create_table :posts do |t|
            t.string :permalink
            t.string :title
            t.text :body
            t.string :status
            t.text :announcement
            t.references :category
            t.references :author
            t.integer :comments_count, :default => 0
            t.integer :rating, :default => 0
            t.timestamps
        end
    end

    def self.down
        drop_table :posts
    end
end
