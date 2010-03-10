class Favourite < ActiveRecord::Base  
  belongs_to :user
  belongs_to :object, :polymorphic => true, :dependent => :destroy
end
