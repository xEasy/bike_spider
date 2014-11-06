class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :title, type: String
  field :url,   type: String
  field :from,  type: String
  field :author,  type: String
  field :p_date,  type: String

  validates :title, :url, uniqueness: true
  scope :with_tag, ->(tag) { where(from: tag) }

  def self.all_tags
    [
      [:hz,  2],
      [:cb,  6],
      [:qd,  4],
      [:dfh, 4],
      [:qxz, 3],
      [:gzc, 3]
    ]
  end

end
