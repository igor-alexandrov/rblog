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
    t.announcement = "Исходя из структуры пирамиды Маслоу, продукт раскручивает портрет потребителя, отвоевывая свою долю рынка. Стимулирование коммьюнити упорядочивает фактор коммуникации, опираясь на опыт западных коллег. Направленный маркетинг отражает социальный статус, опираясь на опыт западных коллег. Сегмент рынка концентрирует повседневный традиционный канал, признавая определенные рыночные тенденции. Портрет потребителя традиционно поддерживает традиционный канал, используя опыт предыдущих кампаний."
    t.body = "Представляется логичным, что креативная концепция все еще интересна для многих. Целевой трафик наиболее полно охватывает межличностный побочный PR-эффект, отвоевывая свою долю рынка. Согласно предыдущему, сущность и концепция маркетинговой программы интегрирована. Бюджет на размещение ригиден. В рамках концепции Акоффа и Стэка, стимулирование сбыта регулярно ускоряет SWOT-анализ, не считаясь с затратами.
Надо сказать, что конкурентоспособность спорадически упорядочивает повседневный стратегический рыночный план, расширяя долю рынка. Метод изучения рынка, анализируя результаты рекламной кампании, ускоряет выставочный стенд, опираясь на опыт западных коллег. Ребрендинг, конечно, отражает социометрический процесс стратегического планирования, полагаясь на инсайдерскую информацию. Маркетинговая коммуникация непосредственно индуцирует медиамикс, опираясь на опыт западных коллег. Стоит отметить, что цена клика подсознательно охватывает социометрический отраслевой стандарт, учитывая современные тенденции. Бизнес-план концентрирует целевой сегмент рынка, осознавая социальную ответственность бизнеса."
end
first_topic.save

first_post = Post.new do |p|
    p.title = "Фирменный медийный канал: гипотеза и теории"
    p.content = first_topic
    p.category = category
    p.author = admin_user
    p.tag_list = "test, post, говно, маркетинг"
end
first_post.save
first_post.publish!

first_comment = Comment.new do |c|
    c.post = first_post
    c.parent_comment = fake_comment
    c.commenter_name = "Igor Alexandrov"
    c.commenter_email = "igor.alexandrov@gmail.com"
    c.author = admin_user
    c.body = "First comment"
end
first_comment.save

second_comment = Comment.new do |c|
    c.post = first_post
    c.parent_comment = first_comment
    c.commenter_name = "Igor Alexandrov"
    c.commenter_email = "igor.alexandrov@gmail.com"
    c.author = admin_user
    c.body = "First comment"
end
second_comment.save

third_comment = Comment.new do |c|
    c.post = first_post
    c.parent_comment = fake_comment
    c.commenter_name = "Igor Alexandrov"
    c.commenter_email = "igor.alexandrov@gmail.com"
    c.author = admin_user
    c.body = "First comment"
end
third_comment.save

second_topic = Topic.new do |t|
    t.announcement = "Референдум неравномерен. Политическая социализация неоднозначна. Как уже подчеркивалось, политическое учение Монтескье однозначно верифицирует идеологический постиндустриализм, подчеркивает президент. Политическое учение Фомы Аквинского, на первый взгляд, отражает элемент политического процесса, что получило отражение в трудах Михельса. Понятие политического конфликта традиционно приводит экзистенциальный бихевиоризм, отмечает автор, цитируя К. Маркса и Ф. Энгельса."
    t.body = "Политическое учение Локка иллюстрирует системный марксизм, подчеркивает президент. Политическое учение Фомы Аквинского, однако, последовательно. Понятие политического участия практически символизирует системный коммунизм, такими словами завершается послание Федеральному Собранию. Политическое учение Фомы Аквинского сохраняет эмпирический элемент политического процесса (терминология М. Фуко).
Еще Шпенглер в 'Закате Европы' писал, что политическое учение Руссо интегрирует онтологический элемент политического процесса, впрочем, это несколько расходится с концепцией Истона. Парадигма трансформации общества, как правило, вызывает культ личности, утверждает руководитель аппарата Правительства. Согласно данным Фонда 'Общественное мнение', коммунизм интегрирует онтологический субъект политического процесса, последнее особенно ярко выражено в ранних работах В.И. Ленина. Марксизм сохраняет тоталитарный тип политической культуры, отмечает автор, цитируя К. Маркса и Ф. Энгельса. Важным для нас является указание Маклюэна на то, что унитарное государство интегрирует идеологический англо-американский тип политической культуры, хотя на первый взгляд, российские власти тут ни при чем."
end
second_topic.save

second_post = Post.new do |p|
    p.title = "Почему самопроизвольно понятие политического конфликта?"
    p.content = second_topic
    p.category = category
    p.author = admin_user
  p.tag_list = "test, post, политология"
end
second_post.save
second_post.publish!

first_link = Link.new do |l|
  l.url = "http://www.connectify.ru"
  l.text = "www.connectify.ru"
  l.description = "Клёвые ребята! Делают отличные вещи на Рельсе."
end

third_post = Post.new do |p|
    p.title = "www.connectify.ru"
    p.content = first_link
    p.category = category
    p.author = admin_user
  p.tag_list = "программирование"
end
third_post.save
third_post.publish!