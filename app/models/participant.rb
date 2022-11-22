class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :room

  scope :except_user, -> (user) { where.not(user: user).first }
end
