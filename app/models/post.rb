class Post < ActiveRecord::Base
  # Associations
  #
  belongs_to :user, touch: true
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :dislikes, as: :dislikeable, dependent: :destroy

  # Validations
  #
  validates :user,
            presence: true

  validates :title,
            presence: true,
            length: { in: 1..80 }

  validates :abstract,
            presence: true,
            length: { in: 1..255 }

  validates :content,
            presence: true

  # validates :state,
  #           presence: true
  #
  # validates :likes_count,
  #           presence: true
  #
  # validates :dislikes_count,
  #           presence: true

end
