class UserSession < Authlogic::Session::Base
  logout_on_timeout true
  generalize_credentials_error_messages true
  validate :must_not_be_blocked
  
  private
  def must_not_be_blocked
    unless attempted_record.nil?
      errors.add_to_base("Your account is blocked") if attempted_record.blocked?
    end
  end
end