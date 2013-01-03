require 'money'

module A2z
  module Responses
    class Offer
      attr_accessor :listing_id, :condition, :price, :amount_saved,
                    :percentage_saved, :availability
      
      def initialize
        @price = Money.new(0, 'USD')
        @amount_saved = Money.new(0, 'USD')
        @percentage_saved = 0
        @super_saver_shipping_eligible = false
      end
      
      def price=(value)
        value = Money.new(value, 'USD') unless value.kind_of?(Money)
        @price = value
      end
      
      def amount_saved=(value)
        value = Money.new(value, 'USD') unless value.kind_of?(Money)
        @amount_saved = value
      end
      
      def super_saver_shipping_eligible=(value)
        @super_saver_shipping_eligible = !!value
      end
      
      def super_saver_shipping_eligible?
        @super_saver_shipping_eligible
      end
      
      def self.from_response(data)
        new.tap do |offer|
          if (attributes = data['OfferAttributes'])
            offer.condition = attributes['Condition']
          end
          
          if (listing = data['OfferListing'])
            offer.listing_id = listing['OfferListingId']
            offer.price = Money.new(listing['Price']['Amount'].to_i, listing['Price']['CurrencyCode']) if listing['Price']
            offer.amount_saved = Money.new(listing['AmountSaved']['Amount'].to_i, listing['AmountSaved']['CurrencyCode']) if listing['AmountSaved']
            offer.percentage_saved = listing['PercentageSaved'].to_i
            offer.availability = listing['Availability']
            offer.super_saver_shipping_eligible = listing['IsEligibleForSuperSaverShipping'] == '1'
          end
          
          offer.freeze
        end
      end
    end
  end
end
