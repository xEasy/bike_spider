module Spider
  module Tags
    class QdBike < Fetcher
      def initialize(total_page = 5)
        @total_page = total_page
      end

      def id
        'qd_bike'
      end

      def posts
        @posts = []
        @total_page.times do |page|
          res = get "http://bbs.bikehome.net/forum.php?mod=forumdisplay&fid=7&page=#{ page + 1 }"
          p "Get Page: #{ page + 1 }"
          doc = Nokogiri::HTML(res.body)
          table = doc.css('table[summary=forum_7]')
          items = table.xpath('tbody/tr')
          start = 0
          total = items.size
          if page == 0
            start = 8
          end
          items[start..total].each do |item|
            name_info = item.xpath('th').first
            name = name_info.css('a.xst').text.squish
            url = "http://bbs.bikehome.net/#{ name_info.css('a.xst').xpath('@href').text }"
            author = item.css('.deanforumauthor').text.squish
            date = item.css('.deanforumdateline > span > span').text.squish
            @posts << { name: name, url: url, author: author, date: date }
            p "Get: #{ name }"
          end
        end
        @posts
      end
    end
  end
end
