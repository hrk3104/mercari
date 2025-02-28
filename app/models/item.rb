class Item < ApplicationRecord
    belongs_to :user 

    def self.ransackable_attributes(auth_object = nil)
        ["about", "created_at", "id", "id_value", "price", "title", "updated_at", "user_id"]
      end

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  has_many_attached :images
  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations, dependent: :destroy

  validates :title, presence: true
end
