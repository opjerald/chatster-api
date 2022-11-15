class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true

  scope :all_except, -> (user) { where.not(id: user) }

  def jwt_payload
    super()
  end
end
