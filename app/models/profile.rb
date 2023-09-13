class Profile < ApplicationRecord
  belongs_to :user

  # validates :city, length: { in: 4..40 }, allow_nil: false
  # validates :phone_number, length: { in: 6..40 }, allow_nil: false
  # validates :zip, length: { in: 3..40 }, allow_nil: false
  # validates :name, presence: true
  # validates :state, presence: true

  def geocode
    Geocoder.search(addr_line_1 + ',' + city)[0].data
  end

  def lat
    geocode['lat']
  end

  def lon
    geocode['lon']
  end
end
