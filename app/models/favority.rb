class Favority
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  belongs_to :post

  validates :post_id, uniqueness: true
end
