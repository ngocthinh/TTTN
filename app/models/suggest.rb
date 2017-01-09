class Suggest < ApplicationRecord
  belongs_to :user

  mount_uploader :up_picture, PictureUploader
  scope :suggest_user, ->id do  
  select("suggests.*").
      where("user_id = ?", id)
  end
end
