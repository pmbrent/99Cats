class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate  :non_conflicting_scheduling

  belongs_to :cat

  def approve!
    if status == "PENDING"
      status = "APPROVED"
      CatRentalRequest.transaction do
        self.save!
        overlapping_pending_requests.each do |request|
          request.deny!
        end
      end
    end
  end

  def deny!
    status = "DENIED"
    self.save!
  end

private

  def non_conflicting_scheduling
    if overlapping_approved_requests.count > 0
      errors[:cat_rental_request] << "Scheduling conflict"
    end
  end

  def overlapping_requests
    appointments = CatRentalRequest.where(cat_id: self.cat_id)

    appointments.select do |appt|
      start_date < appt.end_date && end_date > appt.start_date
    end
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

end
