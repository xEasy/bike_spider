require 'spider'

class PostSpider
  def perform(tag)
    case tag
    when 'hz'
      fetch_hz_bike
    when 'cb'
      fetch_cb_bike
    when 'qd'
      fetch_qd_bike
    end
  end

  private
  def fetch_cb_bike
    fetcher = Spider::Tags::CbBike.new(5)
    batch_create_post(fetcher.posts, fetcher)
  end

  def fetch_qd_bike
    fetcher = Spider::Tags::QdBike.new(5)
    batch_create_post(fetcher.posts, fetcher)
  end

  def fetch_hz_bike
    fetcher = Spider::Tags::HzBike.new(3)
    batch_create_post(fetcher.posts, fetcher)
  end

  def batch_create_post(posts, fetcher)
    posts.each do |p|
      Post.create(
        title:   p[:name],
        author:  p[:author],
        p_date:  p[:date],
        url:     p[:url],
        from:  fetcher.id
      )
    end
  end
end
