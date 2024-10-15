class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property
  has_one :review, dependent: :destroy
  validates :start_date, :end_date, presence: true
  # validates :end_date_after_start_date
end
# comment to fix an issue
