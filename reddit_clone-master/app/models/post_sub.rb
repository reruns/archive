class PostSub < ActiveRecord::Base
  validates :post, :sub, presence: true

  belongs_to(:post, class_name: 'Post', inverse_of: :post_subs,
             foreign_key: :post_id, primary_key: :id)

  belongs_to(:sub, class_name: 'Sub',  inverse_of: :post_subs,
             foreign_key: :sub_id, primary_key: :id)
end
