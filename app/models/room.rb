class Room < ApplicationRecord
  has_many :messages
  has_many :participants, dependent: :destroy

  scope :public_rooms, -> { where(is_private: false) }

  def self.create_private_room(users, room_name)
    room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user: user, room: room)
    end
    room
  end

  def participant?(room, user)
    room.participant?.where(user: user).exists?
  end
end
