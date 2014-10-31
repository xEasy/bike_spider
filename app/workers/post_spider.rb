require 'spider'

class PostSpider
  def perform(tag)
    case tag
    when 'hz'
      fetch_hz_bike
    end
  end

  private
  def fetch_hz_bike
    posts = Spider::Tags::HzBike.new(3).posts
    posts.each do |p|
      Post.create(
        title: p[:name],
        info:  p[:info],
        url:   p[:url]
      )
    end
  end
end
