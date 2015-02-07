class Dislike < ActiveRecord::Base
  # Associations
  #
  belongs_to :dislikeable, polymorphic: true, touch: true
  belongs_to :user, touch: true

  # Validations
  #
  validates :dislikeable,
            presence: true

  validates :user,
            presence: true
end
