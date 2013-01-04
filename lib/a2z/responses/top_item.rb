module A2z
  module Responses
    class TopItem
      attr_accessor :asin, :title, :product_group, :actor, :artist, :author,
                    :detail_page_url
      
      def self.from_response(data)
        new.tap do |top_item|
          top_item.asin = data['ASIN']
          top_item.title = data['Title']
          top_item.product_group = data['ProductGroup']
          top_item.actor = data['Actor']
          top_item.artist = data['Artist']
          top_item.author = data['Author']
          top_item.detail_page_url = data['DetailPageURL']
          top_item.freeze
        end
      end
    end
  end
end
