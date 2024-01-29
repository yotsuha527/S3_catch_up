class Group < ApplicationRecord
  has_one_attached :group_image

  has_many :group_users
  has_many :users, through: :group_user

  def get_group_image(weight, height)
    unless self.group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    self.group_image.variant(resize_to_fill: [weight,height]).processed
  end

  def add_user(user)
    group_users.create({user_id: user.id, group_id: id})
  end
end
