class User < ActiveRecord::Base
  # Associations
  #
  belongs_to :gender, touch: true
  has_secure_password

  # Validations
  #
  validates :first_name,
            presence: true

  validates :last_name,
            presence: true

  validates :gender,
            presence: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            }

  validates :password,
            presence: true

  def to_s
    "#{first_name} #{last_name}"
  end
end
