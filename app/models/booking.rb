class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property
  has_one :review, dependent: :destroy
  validates :start_date, :end_date, presence: true
  validates :number_of_guests, presence: true # Number of guests is now required
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    # this method validates if the end_date is earlier than the start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
