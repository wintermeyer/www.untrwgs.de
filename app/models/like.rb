class Like < ActiveRecord::Base
  # Associations
  #
  belongs_to :likeable, polymorphic: true, touch: true
  belongs_to :user, touch: true

  # Validations
  #
  validates :likeable,
            presence: true

  validates :user,
            presence: true
end
