module Spider
  module Tags
    class HzBike < Fetcher
      def initialize(total_page = 5)
        @total_page = total_page
      end
      def url
        "http://www.51bike.com/forum-7-1.html"
      end

      def posts
        @posts = []
        @total_page.times do |page|
          res = get "http://www.51bike.com/forum-7-#{ page + 1 }.html"
          p "Get Page: #{ page + 1 }"
          doc = Nokogiri::HTML(res.body)
          table = doc.css('#threadlisttableid')
          items = table.xpath('tbody/tr')
          start = 0
          total = items.size
          if page == 0
            start = 10
          end
          items[start..total].each do |item|
            name_info = item.xpath('th').first
            name = name_info.css('a.xst').text.squish
            url = "http://www.51bike.com/#{ name_info.css('a.xst').xpath('@href').text }"
            info = item.xpath('td[2]').text.squish
            @posts << { name: name, url: url, info: info }
            p "Get: #{ name }"
          end
        end
        @posts
      end
    end
  end
end
