class Notifier < ActionMailer::Base
  def activation_instructions(user)
    subject       "#{configatron.general.blog_name } activation instructions"
    from          configatron.general.blog_contact_email
    recipients    user.email
    sent_on       Time.now
    body          :user => user
    content_type  "text/html"
  end

  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "igor.alexandrov@gmail.com"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end
end
