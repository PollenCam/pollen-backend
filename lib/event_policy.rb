class EventPolicy
  attr_accessor :start_time, :current_time, :payment_at, :end_time,
                :upload_period, :free_download_period, :accepting_payments_period

  TWENTY_FOUR_HOURS = 24.hours
  FOURTEEN_DAYS = 14.days
  THIRTY_DAYS = 30.days

  def initialize(start_time: , current_time: Time.now, payment_at: nil)
    raise ArgumentError, 'Event start time must be before current time' if current_time < start_time

    @start_time, @current_time, @payment_at, @end_time = \
      start_time, current_time, payment_at, start_time + THIRTY_DAYS

    @upload_period = start_time..(start_time + TWENTY_FOUR_HOURS)
    @free_download_period = start_time..(start_time + FOURTEEN_DAYS)
    @accepting_payments_period = (start_time + FOURTEEN_DAYS)..end_time
  end

  def can_upload?
    upload_period.include?(current_time)
  end

  def can_download?
    return false if end_time < current_time unless paid_access?

    free_downloads? || valid_payment?
  end

  private

  def free_downloads?
    free_download_period.include?(current_time)
  end

  def valid_payment?
    accepting_payments_period.include?(payment_at) && paid_access?
  end

  def paid_access?
    return false if payment_at.nil?
    (payment_at..(payment_at + THIRTY_DAYS)).include? current_time
  end
end
