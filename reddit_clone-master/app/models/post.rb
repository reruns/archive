class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to(:author, class_name: 'User',
             foreign_key: :author_id, primary_key: :id)
  has_many(:post_subs, class_name: 'PostSub', inverse_of: :post,
           foreign_key: :post_id, primary_key: :id)
  has_many :comments
  has_many :subs, through: :post_subs, source: :sub

  def top_level_comments
    comments.where(parent_comment_id: nil)
  end

  def comments_by_parent_id
    c_hash = Hash.new { |h,k| h[k] = [] }
    comments.each do |comment|
      c_hash[comment.parent_comment_id] << comment
    end

    c_hash
  end
  
end
