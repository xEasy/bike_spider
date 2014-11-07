require 'spider'

class PostSpider
  def fetch_all
    @s_count = Post.count
    Post.all_tags.each do |tag, page_count|
      begin
        fetch_bike(tag, page_count)
      rescue => e
        p "ERROR: while catching #{ tag }, #{ e.message }"
      end
    end

    fetch_count = Post.count - @s_count
    p "新获取: #{ fetch_count } 条交易记录"
    fetch_count
  end

  def perform(tag)
    @s_count = Post.count
    @total_page = 3
    fetch_bike(tag)
    p "新获取: #{ Post.count - @s_count } 条交易记录"
  end

  private
  def fetch_bike(tag, total = @total_page)
    p "====== Fetching #{ tag } ====== "
    fetcher = spider_mapper(tag).new(total)
    batch_create_post(fetcher.posts, fetcher)
  end

  def spider_mapper(tag)
    {
      hz:  Spider::Tags::HzBike,
      cb:  Spider::Tags::CbBike,
      dfh: Spider::Tags::DfhBike,
      qd:  Spider::Tags::QdBike,
      qxz: Spider::Tags::QxzBike,
      gzc: Spider::Tags::GzcBike
    }[tag.to_sym]
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
