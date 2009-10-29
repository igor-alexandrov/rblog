# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Post.find(:all).each { |e| e.destroy  }
Comment.find(:all, :conditions => "id != 0").each { |e| e.destroy  }
User.find(:all).each { |e| e.destroy  }

fake_comment = Comment.find( :first, :conditions => "id=0" )
if fake_comment.nil?
  fake_comment = Comment.new do |c|
      c.id = 0
      c.post_id = nil
      c.parent_comment_id = nil
      c.commenter_name = 'rblog developer'
      c.commenter_email = 'igor.alexandrov@gmail.com'
      c.body = 'This comment is here to provide tree comment model. All other top level comments will have parent_comment_id = 0'
    end

    fake_comment.save
end

first_post = Post.new do |p|
    p.title = "Welcome!"
    p.permalink = "welcome"
    p.announcement = ""
    p.body = "It is your first post in RBlog it, doesn't have an announcement, so you can see it all."
    p.status = "published"
end
first_post.save

first_comment = Comment.new do |c|
    c.post = first_post
    c.parent_comment = fake_comment
    c.commenter_name = "Igor Alexandrov"
    c.commenter_email = "igor.alexandrov@gmail.com"
    c.body = "First comment"
end
first_comment.save

second_comment = Comment.new do |c|
    c.post = first_post
    c.parent_comment = first_comment
    c.commenter_name = "Igor Alexandrov"
    c.commenter_email = "igor.alexandrov@gmail.com"
    c.body = "First comment"
end
second_comment.save

third_comment = Comment.new do |c|
    c.post = first_post
    c.parent_comment = fake_comment
    c.commenter_name = "Igor Alexandrov"
    c.commenter_email = "igor.alexandrov@gmail.com"
    c.body = "First comment"
end
third_comment.save

second_post = Post.new do |p|
    p.title = "Second post!"
    p.permalink = "second_post"
    p.announcement = "Announcement of post."
    p.body = "Second post. It is it's body."
    p.status = "published"
end
second_post.save

admin_user = User.new do |user|
  user.login = "admin"
  user.password = "admin"
  user.password_confirmation = "admin"
end

admin_user.save