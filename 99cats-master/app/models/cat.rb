class Cat < ActiveRecord::Base
  COLORS = %w(black white orange tabby calico lime_green)

  validates :birth_date, :color, :name, :sex, :description, :user_id, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: %w(M F) }

  has_many(:rental_requests, class_name: 'CatRentalRequest',
           foreign_key: :cat_id, primary_key: :id, dependent: :destroy)
  belongs_to(:user, class_name: 'User', foreign_key: :user_id, primary_key: :id)


end
