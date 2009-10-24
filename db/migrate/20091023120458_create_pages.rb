class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.references :parent
      t.string :title, :null => false
      t.text :content
      t.string :permalink, :null => false
      t.boolean :is_index, :default => false
      t.timestamps
    end

    add_index :pages, :permalink
    add_index :pages, :parent_id

    index_page = Page.new({:title => "RBlog index page", :permalink => "", :is_index => true})
    index_page.save

    about_page = Page.new({:title => "About RBlog", :permalink => "about", :content => "RBlog - Rails blog engine"})
    about_page.save

  end

  def self.down
    remove_index :pages, :permalink
    remove_index :pages, :parent_id
    drop_table :pages
  end
end
