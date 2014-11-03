module Spider
  module Tags
    class GzcBike < HzBike
      def initialize(total_page = 5)
        @total_page = total_page
        @host = "http://www.gzcycling.com"
        @start = 5
      end

      def id
        'gzc_bike'
      end

      def url(page)
        "http://www.gzcycling.com/forum-103-#{ page }.html"
      end

      def gen_item_link(path)
        path
      end
    end
  end
end
