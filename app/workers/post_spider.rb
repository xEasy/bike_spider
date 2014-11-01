require 'spider'

class PostSpider
  def fetch_all
    @s_count = Post.count
    fetch_hz_bike(1)
    fetch_cb_bike(2)
    fetch_qd_bike(2)
    fetch_dfh_bike(2)

    p "新获取: #{ Post.count - @s_count } 条交易记录"
  end

  def perform(tag)
    @s_count = Post.count
    @total_page = 3
    case tag
    when 'hz'
      fetch_hz_bike
    when 'cb'
      fetch_cb_bike
    when 'qd'
      fetch_qd_bike
    when 'dfh'
      fetch_dfh_bike
    end
    p "新获取: #{ Post.count - @s_count } 条交易记录"
  end

  private
  def fetch_dfh_bike(total = @total_page)
    fetcher = Spider::Tags::DfhBike.new(total)
    batch_create_post(fetcher.posts, fetcher)
  end

  def fetch_cb_bike(total = @total_page)
    fetcher = Spider::Tags::CbBike.new(total)
    batch_create_post(fetcher.posts, fetcher)
  end

  def fetch_qd_bike(total = @total_page)
    fetcher = Spider::Tags::QdBike.new(total)
    batch_create_post(fetcher.posts, fetcher)
  end

  def fetch_hz_bike(total = @total_page)
    fetcher = Spider::Tags::HzBike.new(total)
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
