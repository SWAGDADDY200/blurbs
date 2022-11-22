class User < ApplicationRecord

  include PgSearch::Model
  multisearchable against: [:name, :username]
  
  validates :name, presence: true, length: { minimum: 1, maximum: 16 }
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_FORMAT }, uniqueness: true

  before_save { self.email = email.downcase }

  has_many :blurbs, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  has_one_attached :image

  has_rich_text :bio

  validates :location, length: { minimum: 1, maximum: 30 }, if: :location_changed?

  has_one_attached :banner

  has_one :birthday

  validates :username, presence: true, length: { minimum: 1, maximum: 16 }, uniqueness: true

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed

  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

end

