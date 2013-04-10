module WillPaginate
  module Sinatra
    class LinkRenderer < ViewHelpers::LinkRenderer
      protected

      def url(page)
        "/search/page#{page.to_s}" << '?' << build_query(request.GET)
      end
    end
  end
end