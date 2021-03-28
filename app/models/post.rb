class Post < ApplicationRecord
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  attachment :post_image
  
  validates :title, :post_content, presence: true
end
