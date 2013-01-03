require 'money'

module A2z
  module Responses
    class OfferSummary
      attr_accessor :lowest_new_price, :lowest_used_price, :total_new,
                    :total_used, :total_collectible, :total_refurbished
      
      def initialize
        @lowest_new_price = Money.new(0, 'USD')
        @lowest_used_price = Money.new(0, 'USD')
        @total_new = 0
        @total_used = 0
        @total_collectible = 0
        @total_refurbished = 0
      end
      
      def lowest_new_price=(value)
        value = Money.new(value, 'USD') unless value.kind_of?(Money)
        @lowest_new_price = value
      end
      
      def lowest_used_price=(value)
        value = Money.new(value, 'USD') unless value.kind_of?(Money)
        @lowest_used_price = value
      end
      
      def total_new=(value)
        @total_new = value.to_i
      end
      
      def total_used=(value)
        @total_used = value.to_i
      end
      
      def total_collectible=(value)
        @total_collectible = value.to_i
      end
      
      def total_refurbished=(value)
        @total_refurbished = value.to_i
      end
      
      def self.from_response(data)
        new.tap do |offer_summary|
          if data['LowestNewPrice']
            offer_summary.lowest_new_price = Money.new(data['LowestNewPrice']['Amount'].to_i, data['LowestNewPrice']['CurrencyCode'])
          end
          
          if data['LowestUsedPrice']
            offer_summary.lowest_used_price = Money.new(data['LowestNewPrice']['Amount'].to_i, data['LowestNewPrice']['CurrencyCode'])
          end
          
          offer_summary.total_new = data['TotalNew']
          offer_summary.total_used = data['TotalUsed']
          offer_summary.total_collectible = data['TotalCollectible']
          offer_summary.total_refurbished = data['TotalRefurbished']
          
          offer_summary.freeze
        end
      end
    end
  end
end
