class Blurb < ApplicationRecord
  belongs_to :user

  has_one_attached :picture
  has_rich_text :body
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, length: { minimum: 1, maximum: 1000 }

  def liked_by?(liking_user)
    like_for_user(liking_user).present?
  end

  def like_for_user(liking_user)
    return if liking_user.nil?

    likes.find_by_user_id(liking_user.id)
  end
end
