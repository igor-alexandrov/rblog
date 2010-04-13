class VersionController < ApplicationController
  def index
    @repo = Octopi::Repository.find(:user => "igor-alexandrov", :repo => "rblog")
    @git = Git.open(RAILS_ROOT)
  end
end