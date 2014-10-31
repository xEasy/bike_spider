class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :title, type: String
  field :url,   type: String
  field :from,  type: String
  field :author,  type: String
  field :p_date,  type: String

  validates :title, :url, uniqueness: true
end
