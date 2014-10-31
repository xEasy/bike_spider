require 'spider'

class PostSpider
  def fetch_all
    @s_count = Post.count
    @total_page = 1
    perform('hz')
    perform('qd')
    perform('cb')

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
    end
    p "新获取: #{ Post.count - @s_count } 条交易记录"
  end

  private
  def fetch_cb_bike
    fetcher = Spider::Tags::CbBike.new(@total_page)
    batch_create_post(fetcher.posts, fetcher)
  end

  def fetch_qd_bike
    fetcher = Spider::Tags::QdBike.new(@total_page)
    batch_create_post(fetcher.posts, fetcher)
  end

  def fetch_hz_bike
    fetcher = Spider::Tags::HzBike.new(@total_page)
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
