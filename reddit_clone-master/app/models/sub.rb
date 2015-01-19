class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  belongs_to(:moderator, class_name: 'User',
             foreign_key: :moderator_id, primary_key: :id)
  has_many(:post_subs, class_name: 'PostSub', inverse_of: :sub,
          foreign_key: :sub_id, primary_key: :id)
  # has_many(:posts, class_name: 'Post',
  #          foreign_key: :sub_id, primary_key: :id)
  has_many :posts, through: :post_subs, source: :post
end
