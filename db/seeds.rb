# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Post.find(:all).each { |e| e.destroy  }
Topic.find(:all).each { |e| e.destroy  }
Link.find(:all).each { |e| e.destroy  }
Comment.find(:all).each { |e| e.destroy  }
User.find(:all).each { |e| e.destroy  }

admin_user = User.new do |user|
  user.login = "admin"
  user.password = "admin"
  user.password_confirmation = "admin"
  user.email = "admin@example.com"
  user.first_name = "Admin"
  user.last_name = "Admin"
  user.date_of_birth = Date.today
  user.role = "ADMIN"
  
end

admin_user.save

igor_user = User.new do |user|
  user.login = "igor"
  user.password = "igor"
  user.password_confirmation = "igor"
  user.email = "alexandrov@connectify.ru"
  user.first_name = "Igor"
  user.last_name = "Alexandrov"
  user.date_of_birth = Date.today
  user.role = "GENERAL"
end

igor_user.save


#fake_comment = Comment.find( :first, :conditions => "id=0" )
#if fake_comment.nil?
#  fake_comment = Comment.new do |c|
#      c.id = 0
#      c.post_id = nil
#      c.parent_comment_id = nil
#      c.commenter_name = 'rblog developer'
#      c.commenter_email = 'igor.alexandrov@gmail.com'
#      c.body = 'This comment is here to provide tree comment model. All other top level comments will have parent_comment_id = 0'
#    end
#
#    fake_comment.save
#end

Category.find(:all).each { |e| e.destroy  }
category = Category.new do |c|
  c.permalink = "general"
  c.title = "General"
  c.decription = "Default RBlog category"
  c.enabled = true
  c.posts_count = 0
end

category.save

first_topic = Topic.new do |t|
    t.body = "Welcome!

You have just installed RBlog.\n
RBlog is a modern blog engine with elements of social network, written with Ruby On Rails.\n\n
If you have any questions, please mail to <a href=\"igor.alexandrov@gmail.com\">igor.alexandrov@gmail.com</a> or to <a href=\"info@connectify.ru\">info@connectify.ru</a>.\n
If you want to know more about RBlog or take a parn in development, please visiti our <a href=\"http://github.com/igor-alexandrov/rblog\">GitHub page</a>."
end
first_topic.save

first_post = Post.new do |p|
    p.title = "Welcome to RBlog!"
    p.content = first_topic
    p.category = category
    p.author = admin_user
    p.tag_list = "rblog, ruby, welcome"
end
first_post.save
first_post.publish!

first_comment = UserComment.new do |c|
    c.post = first_post
#    c.parent_comment = fake_comment
#    c.commenter_name = "Igor Alexandrov"
#    c.commenter_email = "igor.alexandrov@gmail.com"
    c.author = igor_user
    c.body = "First comment"
end
first_comment.save

second_comment = UserComment.new do |c|
    c.post = first_post
    c.parent_comment = first_comment
#    c.commenter_name = "Igor Alexandrov"
#    c.commenter_email = "igor.alexandrov@gmail.com"
    c.author = admin_user
    c.body = "Second comment"
end
second_comment.save

third_comment = UserComment.new do |c|
    c.post = first_post
#    c.parent_comment = fake_comment
#    c.commenter_name = "Igor Alexandrov"
#    c.commenter_email = "igor.alexandrov@gmail.com"
    c.author = admin_user
    c.body = "Third comment"
end
third_comment.save

second_topic = Topic.new do |t|
    t.announcement = "Find out what people say about Ruby on Rails"
    t.body = "“Ruby on Rails is a breakthrough in lowering the barriers of entry to programming.
Powerful web applications that formerly might have taken weeks or months
to develop can be produced in a matter of days.”
-Tim O'Reilly, Founder of O'Reilly Media"
end
second_topic.save

second_post = Post.new do |p|
    p.title = "Ruby on Rails"
    p.content = second_topic
    p.category = category
    p.author = admin_user
  p.tag_list = "ruby on rails"
end
second_post.save
second_post.publish!

first_link = Link.new do |l|
  l.url = "http://www.connectify.ru"
  l.text = "www.connectify.ru"
  l.description = "Visit our site and get more information about us."
end

third_post = Post.new do |p|
    p.title = "www.connectify.ru"
    p.content = first_link
    p.category = category
    p.author = admin_user
  p.tag_list = "connectify.ru, russia"
end
third_post.save
third_post.publish!