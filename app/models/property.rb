class Property < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings, dependent: :destroy

  # Ensure validations are consistent
  validates :title, :description, :location, :max_guests, :property_type, presence: true
  validates :price_per_night, numericality: {
    greater_than_or_equal_to: 1,
    message: "must be at least 1"
  }
  validates :max_guests, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 16,
    message: "must be between 1 and 16"
  }

  # Allows multiple images to be attached
  has_many_attached :photos

  # Geocoding configuration
  geocoded_by :location
  after_validation :geocode_location, if: :will_save_change_to_location?

  # Helper to extract city from location
  def city
    location.split(',').last.strip if location.present?
  end

  # Geocoder
  def geocode_location
    if location.present?
      geocode
      if latitude.nil? || longitude.nil?
        errors.add(:location, "could not be geocoded. Please provide a valid address.")
      end
    end
  end

  # pg_search scope for title and location search
  include PgSearch::Model
  pg_search_scope :search_by_title_and_location,
    against: [:title, :location],
    using: {
      tsearch: { prefix: true }
    }
end
