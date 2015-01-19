class Goal < ActiveRecord::Base
  include Commentable

  PRIVACY_TYPES = ["Public", "Private"]

  validates :title, :user_id, :privacy, presence: true
  validates :privacy, inclusion: PRIVACY_TYPES

  belongs_to :user

  def completed?
    self.completed
  end

  def toggle_completed
    self.completed = !self.completed
    self.save!
  end
end
