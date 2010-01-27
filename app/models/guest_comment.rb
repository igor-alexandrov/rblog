class GuestComment < Comment
  validates_presence_of     :guest_commenter_name

  validates_presence_of     :guest_commenter_email
  validates_length_of       :guest_commenter_email,    :within => 6..100
  validates_format_of       :guest_commenter_email,    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
