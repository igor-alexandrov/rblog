class VersionController < ApplicationController
  def index
    @repo = Octopi::Repository.find(:user => "igor-alexandrov", :repo => "rblog")
    @git = Git.open(Rails.root)
  end
end
