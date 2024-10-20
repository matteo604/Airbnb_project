class Property < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings, dependent: :destroy
  has_many_attached :photos # changed to allow multiple images
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model

  # basic pg_search_scope for searching title and location
  pg_search_scope :search_by_title_and_location,
    against: [:title, :location], # search against title and location
    using: {
      tsearch: { prefix: true } # enable prefix search to match partial words
    }
end
