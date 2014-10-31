class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :title, type: String
  field :url,   type: String
  field :info,  type: String

  validates :title, :url, uniqueness: true
end
