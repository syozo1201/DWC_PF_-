class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  attachment :profile_image

  attr_accessor :twitter_image_url

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy

  def self.from_omniauth(auth)
   sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
   user = User.where(email: auth.info.email).first_or_initialize(
    name: auth.info.name,
    email: auth.info.email
    )
    user.twitter_image_url = auth.info.image
   if user.persisted?
     sns.user = user
     sns.save
   end
   { user: user, sns: sns }
  end
end
