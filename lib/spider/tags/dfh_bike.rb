module Spider
  module Tags
    class DfhBike < HzBike
      def initialize(total_page = 5)
        @total_page = total_page
        @host = "http://www.dongfanghong.com.cn/bbs"
        @start = 4
      end

      def id
        'dfh_bike'
      end

      def url(page)
        "http://www.dongfanghong.com.cn/bbs/forum.php?mod=forumdisplay&fid=11&page=#{ page }"
      end

      def get_table_list(doc)
        doc.css('table[summary=forum_11]')
      end
    end
  end
end
