module Spider
  module Tags
    class HzBike < Fetcher
      def initialize(total_page = 5)
        @total_page = total_page
        @host = "http://www.51bike.com"
        @start = 10
      end

      def id
        'hz_bike'
      end

      def url(page)
        "http://www.51bike.com/forum-7-#{ page }.html"
      end

      def posts
        @posts = []
        @total_page.times do |page|
          res = get url(page + 1)
          p "Get Page: #{ page + 1 }"
          doc = Nokogiri::HTML(res.body)
          table = get_table_list(doc)
          items = table.xpath('tbody/tr')
          start = 0
          total = items.size
          if page == 0
            start = @start
          end
          items[start..total].each do |item|
            name_info = item.xpath('th').first
            name = name_info.css('a.xst').text.squish
            url = gen_item_link(name_info.css('a.xst').xpath('@href').text)
            info = item.xpath('td[2]').first #text.squish
            author = info.xpath('cite').text.squish
            date = info.xpath('em').text.squish
            @posts << { name: name, url: url, author: author, date: date }
            p "Get: #{ name }"
          end
        end
        @posts
      end

      def gen_item_link(path)
        "#{ @host }/#{ path }"
      end

      def get_table_list(doc)
        doc.css('#threadlisttableid')
      end
    end
  end
end
