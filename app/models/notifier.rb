class Notifier < ActionMailer::Base
  def activation_instructions(user)
    @user = user
    mail(:to => user.email,
         :subject => "#{configatron.general.blog_name } activation instructions",
         :from => configatron.general.blog_contact_email
        )
  end

  def activation_confirmation(user)
    @root_url = root_url
    mail(:to => user.email,
         :subject => "Activation Complete",
         :from => "igor.alexandrov@gmail.com"
        )
  end
end
