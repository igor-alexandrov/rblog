class CreateBlogParameters < ActiveRecord::Migration
  def self.up
    create_table :blog_parameters do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :blog_parameters
  end
end
