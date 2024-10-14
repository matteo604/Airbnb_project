class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property
  has_one :review, dependent: :destroy
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
end
