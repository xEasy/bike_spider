class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :title, type: String
  field :url,   type: String

  validates :name, :url, uniqueness: true
end
