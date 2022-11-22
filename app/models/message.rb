class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  before_create :confirm_participants

  def confirm_participants
    return unless room.is_private

    is_participant = Participant.where(user: self.user).first
    throw :abort unless is_participant
  end
end
