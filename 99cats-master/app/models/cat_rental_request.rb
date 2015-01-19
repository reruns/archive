class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: {in: STATUSES }
  validate :no_approved_overlapping_requests

  before_validation :set_initial_status

  belongs_to(:cat, class_name: 'Cat', foreign_key: :cat_id, primary_key: :id)
  belongs_to(:requester, class_name: 'User', foreign_key: :user_id, primary_key: :id)


  def overlapping_requests

    #date_condition = "(start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?)
    #                  OR (start_date < ? AND end_date > ?)"

    date_condition = "NOT ((start_date > ?) OR (end_date < ?))"

    requests = CatRentalRequest
                .all
                .where(cat_id: self.cat_id)
                .where(date_condition, self.start_date, self.end_date)
                .where("id IS NULL OR id != ?", self.id)
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def set_initial_status
    self.status ||= "PENDING"
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      save!
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    save!
  end

  def pending?
    status == 'PENDING'
  end

  private

  def no_approved_overlapping_requests
    unless overlapping_approved_requests.empty?
      errors[:base] << "must not have conflicting requests."
    end
  end
end
