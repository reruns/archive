class User < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => true

  has_many(:contacts, class_name: 'Contact', foreign_key: :user_id, dependent: :destroy)

  has_many(
    :contact_shares,
    class_name: 'ContactShare',
    foreign_key: :user_id,
  )

  has_many :shared_contacts, through: :contact_shares, source: :contact
  has_many :comments, as: :commentable
end
