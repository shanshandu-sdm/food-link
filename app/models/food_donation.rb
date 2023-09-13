class FoodDonation < ApplicationRecord
  belongs_to :user, foreign_key: 'restaurant_id'

  validates :available_at, presence: true
  validates :quantity, presence: true
  validates :note, presence: true

  enum status: {
    available: 0,
    requested: 1,
    picked_up: 2
  }

  def self.to_csv
    attributes = %w[restaurant charity quantity status note review available_at created_at updated_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |donation|
        csv << attributes.map { |attr| donation.send(attr) }
      end
    end
  end

  def charity
    User.find_by(id: charity_id)&.profile&.name
  end

  def restaurant
    self.user.profile.name
  end

  def profile
    self.user.profile
  end
end
