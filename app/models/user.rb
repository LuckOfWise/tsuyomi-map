class User < ApplicationRecord
  has_many :strengths, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :strengths, allow_destroy: true
  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships

  def save_with_omniauth!(auth)
    self.provider = auth['provider']
    self.uid = auth['uid']
    self.email = auth['info']['email']
    self.name = auth['info']['name']
    self.icon_url = auth['info']['image']
    self.save!
  end

  def inputted?
    strengths.count >= 5
  end
end
