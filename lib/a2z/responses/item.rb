module A2z
  module Responses
    class Item
      include Helpers
      
      attr_accessor :asin, :detail_page_url, :links
      
      def initialize
        @links = []
      end
      
      def []=(key, value)
        instance_variable_set("@#{key}".to_sym, value)
        self.class.class_eval { attr_reader key.to_sym }
      end
      
      def self.from_response(data)
        new.tap do |item|
          item.asin = data['ASIN']
          item.detail_page_url = data['DetailPageURL']
          
          if data['ItemLinks']
            item.links = data['ItemLinks']['ItemLink'].collect { |link| ItemLink.from_response(link) }
          end
          
          if data['ItemAttributes']
            data['ItemAttributes'].each { |key, value| item[underscore(key)] = value }
          end
          
          item.freeze
        end
      end
    end
  end
end
