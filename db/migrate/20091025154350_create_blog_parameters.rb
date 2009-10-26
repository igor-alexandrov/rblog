class CreateBlogParameters < ActiveRecord::Migration
   def self.up
    create_table :blog_parameters do |t|
      t.string :key
      t.string :description
      t.string :value

      t.timestamps
    end

     add_index :blog_parameters, :key

  end

  def self.down
    drop_table :blog_parameters
  end
end
