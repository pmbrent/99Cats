class CatRentalRequest < ActiveRecord::Base

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ["PENDING", "APPROVED", "DENIED"]}
  validate :non_conflicting_scheduling

  belongs_to :cat

private
  def non_conflicting_scheduling
    if overlapping_approved_requests
      errors[:cat_rental_request] << "Scheduling conflict"
    end
  end

  def overlapping_requests
    CatRentalRequest.where(cat_id: self.cat_id)
  end

  def overlapping_approved_requests
      appointments = overlapping_requests.where(status: "APPROVED")

      appointments.any? do |appt|
        appt.start_date.between?(start_date, end_date) ||
        appt.end_date.between?(start_date, end_date) ||
        start_date.between?(appt.start_date, appt.end_date) ||
        end_date.between?(appt.start_date, appt.end_date)
      end
  end

end
