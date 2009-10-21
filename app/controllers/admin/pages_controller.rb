class Admin::PagesController < Admin::AdminController
  before_filter :require_user
  layout "admin/application"

end
