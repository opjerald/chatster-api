class Message < ApplicationRecord
  belongs_to :user

  validates :body, :users, presence: true
end
