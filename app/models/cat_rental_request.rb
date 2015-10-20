class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate  :scheduling

  belongs_to :cat

  def approve!
    if status == "PENDING"
      self.status = "APPROVED"
      CatRentalRequest.transaction do
        self.save!
        overlapping_pending_requests.each do |request|
          request.deny!
        end
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

# private

  def scheduling

    if overlapping_approved_requests.count > 0
      errors.add(:cat_rental_requests, "Scheduling conflict")
    end
  end

  def overlapping_requests
    appointments = CatRentalRequest.where(cat_id: self.cat_id)
      .where("start_date < ? AND end_date > ?", end_date, start_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

end
