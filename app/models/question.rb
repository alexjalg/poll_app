class Question < ActiveRecord::Base
  belongs_to :my_poll
  
  validates :description, presence: true, length: { minimum: 20 }
  validates :my_poll, presence: true
end
