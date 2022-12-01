class Blurb < ApplicationRecord
  
  ActiveSupport.on_load :action_text_rich_text do
    include PgSearch::Model
    multisearchable against: :body

    belongs_to :user

    before_save { content.plain_text_body = content.body.to_plain_text }

    scope :with_content_containing, ->(query) { joins(:rich_text_content).merge(ActionText::RichText.with_body_containing(query)) }

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
  attr_accessible :body, :name, :tag_list
  acts_as_taggable
end
