class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :title,   type: String
  field :url,     type: String
  field :from,    type: String
  field :author,  type: String
  field :p_date,  type: String
  field :comment, type: String

  validates :title, :url, uniqueness: true
  scope :with_tag, ->(tag) { where(from: tag) }

  def self.all_tags
    [
      [:cb,  6],
      [:qd,  4],
      [:dfh, 4],
      [:hz,  2],
      [:qxz, 3],
      [:gzc, 3],
      [:bt,  3],
    ]
  end

end
