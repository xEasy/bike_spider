module Spider
  module Tags
    class CbBike < HzBike
      def initialize(total_page = 5)
        @total_page = total_page
        @host = "http://bbs.chinabike.net"
        @start = 7
      end

      def id
        'cb_bike'
      end

      def url(page)
        "http://bbs.chinabike.net/forum-35-#{ page }.html"
      end
    end
  end
end
