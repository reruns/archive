class Note < ActiveRecord::Base
  validates :text, :user_id, :track_id, presence: true

  belongs_to :user
  belongs_to :track
end
