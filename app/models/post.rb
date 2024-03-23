class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one :notification, as: :subject, dependent: :destroy
  
  enum status: { public: 0, non_public: 1 }, _prefix: true

  def get_image
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  image
  end
   
  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end
  
  def self.liked_posts(user, page, per_page)
    includes(:favorites)
    .where(favorites: { user_id: user.id })
    .order(created_at: :desc) 
    .page(page) 
    .per(per_page)
  end
  
end
