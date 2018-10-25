class Team < ApplicationRecord
  has_secure_token

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  attr_accessor :current_user
  validates :name, presence: true
  validates :current_user, presence: true, on: :create

  after_create :create_memberships!

  # after_create
  def create_memberships!
    memberships.create!(user: current_user)
  end
end
