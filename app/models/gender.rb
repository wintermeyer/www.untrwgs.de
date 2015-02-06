class Gender < ActiveRecord::Base
  # Associations
  #
  has_many :users

  # Validations
  #
  validates :value,
            presence: true

  def to_s
    value.to_s
  end

end
