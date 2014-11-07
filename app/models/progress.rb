class Progress
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :status, type: String
  field :fetch_count, type: Integer, default: 0

  before_create :set_status
  scope :doing, -> { where(status: 'new') }
  scope :has_done, -> { where(status: 'done') }

  def done!
    update status: 'done'
  end

  private

  def set_status
    self.status = 'new'
  end

end
