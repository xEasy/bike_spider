module Spider
  module Tags
    class BtBike < HzBike
      def initialize(total_page = 5)
        @total_page = total_page
        @host = 'http://bbs.biketo.com'
        @start = 4
      end

      def id
        'bt_bike'
      end

      def url(page)
        "http://bbs.biketo.com/forum-39-#{ page }.html"
      end

      def get_table_list(doc)
        doc.css('table[summary=forum_39]')
      end
    end
  end
end
