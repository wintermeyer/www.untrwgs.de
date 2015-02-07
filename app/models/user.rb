class User < ActiveRecord::Base
  # Associations
  #
  has_secure_password
  belongs_to :gender, touch: true
  has_many :posts, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :dislikes, as: :dislikeable, dependent: :destroy

  # Validations
  #
  validates :first_name,
            presence: true,
            length: { in: 1..254 }


  validates :last_name,
            presence: true,
            length: { in: 1..254 }

  validates :gender,
            presence: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            },
            length: { in: 1..254 }

  validates :password,
            presence: true

  def to_s
    "#{first_name} #{last_name}"
  end
end
