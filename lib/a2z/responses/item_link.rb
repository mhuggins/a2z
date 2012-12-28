module A2z
  module Responses
    class ItemLink
      attr_accessor :description, :url
      
      def self.from_response(data)
        new.tap do |item_link|
          item_link.description = data['Description']
          item_link.url = data['URL']
          item_link.freeze
        end
      end
    end
  end
end
