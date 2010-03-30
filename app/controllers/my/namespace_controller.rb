class My::NamespaceController < ApplicationController
  helper :all

  before_filter do |controller|
    controller.unauthorized! if controller.cannot? :access, :my
  end
end
