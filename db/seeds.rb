# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r") 
  f.each_line do |line|
    data += line
  end
  return data
end

Post.find(:all).each { |e| e.destroy  }
Topic.find(:all).each { |e| e.destroy  }
Link.find(:all).each { |e| e.destroy  }
Comment.find(:all).each { |e| e.destroy  }
User.find(:all).each { |e| e.destroy  }
Page.find(:all).each { |e| e.destroy  }
SocialConnection.find(:all).each { |e| e.destroy  }
SocialConnectionPattern.find(:all).each { |e| e.destroy  }


admin_user = User.new do |user|
  user.username = "admin"
  user.password = "admin"
  user.password_confirmation = "admin"
  user.email = "admin@example.com"
  user.first_name = "Admin"
  user.last_name = "Admin"
  user.date_of_birth = Date.today
  user.role = "ADMIN"
  user.active = 1 
end

admin_user.save

igor_user = User.new do |user|
  user.username = "igor"
  user.password = "igor"
  user.password_confirmation = "igor"
  user.email = "alexandrov@connectify.ru"
  user.first_name = "Igor"
  user.last_name = "Alexandrov"
  user.date_of_birth = Date.today
  user.role = "GENERAL"
end

igor_user.save

Category.find(:all).each { |e| e.destroy  }
category = Category.new do |c|
  c.permalink = "general"
  c.title = "General"
  c.description = "Default RBlog category"
  c.enabled = true
  c.posts_count = 0
end

category.save

first_topic = Topic.new(:body =>  get_file_as_string("#{RAILS_ROOT}/db/data/posts/welcome.html"))
first_topic.save

first_post = Post.new do |p|
    p.title = "Welcome to RBlog!"
    p.content = first_topic
    p.category = category
    p.author = admin_user
    p.tag_list = "rblog, ruby, welcome"
end

second_topic = Topic.new do |t|
    t.body = get_file_as_string("#{RAILS_ROOT}/db/data/posts/authors.html")
end
second_topic.save

second_post = Post.new do |p|
    p.title = "Authors"
    p.content = second_topic
    p.category = category
    p.author = admin_user
  p.tag_list = "rblog, authors"
end

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

second_post.save
second_post.publish!

first_post.save
first_post.publish!

first_comment = UserComment.new do |c|
    c.post = first_post
    c.author = igor_user
    c.body = "First comment"
end
first_comment.save

second_comment = UserComment.new do |c|
    c.post = first_post
    c.parent_comment = first_comment
    c.author = admin_user
    c.body = "Second comment"
end
second_comment.save

third_comment = UserComment.new do |c|
    c.post = first_post
    c.author = admin_user
    c.body = "Third comment"
end
third_comment.save

about_page = Page.new({:title => "About", :content => get_file_as_string("#{RAILS_ROOT}/db/data/pages/about.html")})
about_page.save

license_page = Page.new({:title => "License", :content => get_file_as_string("#{RAILS_ROOT}/db/data/pages/license.html") + "<p><pre>" + get_file_as_string("#{RAILS_ROOT}/LICENSE") + "</pre></p>", :parent => about_page})
license_page.save

twitter = SocialConnectionPattern.new(:name => 'Twitter', :prefix => 'http://twitter.com/')
twitter.save
facebook = SocialConnectionPattern.new(:name => 'Facebook', :prefix => 'http://www.facebook.com/')
facebook.save

admin_user.add_social_connection!(twitter, "igor_alexandrov")
