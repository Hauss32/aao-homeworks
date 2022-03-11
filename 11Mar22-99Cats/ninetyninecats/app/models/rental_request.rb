class RentalRequest < ApplicationRecord
    STATUS = ['PENDING', 'APPROVED', 'DENIED']

    validates :start_date, :end_date, presence: true
    validates :status, presence: true, inclusion: { in: STATUS, message: 
        "%{value} is not a valid status" }
    validate :does_not_overlap_approved_request

    belongs_to :cat

    def deny!
        self.update!(status: 'DENIED')
    end

    def approve!
        transaction do 
            self.update!(status: 'APPROVED')

            overlapping_pending_requests.each do |req|
                req.update!(status: 'DENIED')
            end
        end

    end
    
    private
    def does_not_overlap_approved_request
        return if status == 'DENIED'

        if overlapping_approved_requests.exists?
            errors[:date] << 'overlaps with existing rental.'
        end
    end

    def overlapping_approved_requests
        overlaps = overlapping_requests
        overlapping_requests.where(status: 'APPROVED')
    end

    def overlapping_pending_requests
        overlaps = overlapping_requests
        overlapping_requests.where(status: 'PENDING')
    end

    def overlapping_requests
        rental_cat = Cat.find_by_id(cat_id)
        overlaps = rental_cat
            .rental_requests
            .where('(? between start_date and end_date) OR (? between start_date 
                and end_date)', start_date, end_date)
            .where.not(id: id)

        overlaps
    end
end