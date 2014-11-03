module Spider
  module Tags
    class QxzBike < HzBike
      def initialize(total_page = 5)
        @total_page = total_page
        @host = "http://bbs.cyclist.cn"
        @start = 7
      end

      def id
        'qxz_bike'
      end

      def url(page)
        "http://bbs.cyclist.cn/forum-25-#{ page }.html"
      end
    end
  end
end
