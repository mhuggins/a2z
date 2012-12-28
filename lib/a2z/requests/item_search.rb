module A2z
  module Requests
    class ItemSearch < BlankSlate
      include Helpers
      
      attr_reader :params
      
      def initialize(&block)
        @params = { 'Operation' => 'ItemSearch' }
        instance_eval(&block) if block_given?
      end
      
      %w(Actor Artist AudienceRating Author Brand BrowseNode Composer Conductor
         Condition Director ItemPage Manufacturer MaximumPrice MerchantId
         MinimumPrice MinPercentageOff MusicLabel Orchestra Power Publisher
         Sort Title TruncateReviewsAt VariationPage).each do |param|
        method = underscore(param)
        
        class_eval <<-END, __FILE__, __LINE__
          def #{method}(value)
            @params['#{param}'] = value
          end
        END
      end
      
      def keywords(value)
        value = value.join(' ') if value.kind_of?(Array)
        @params['Keywords'] = value
      end
      
      def category(value)
        @params['SearchIndex'] = value
      end
      
      def response_group(value, &block)
        response_group = ResponseGroup.new(value, &block)
        @params.merge!(response_group.params)
      end
      
      def include_reviews_summary(value)
        @params['IncludeReviewsSummary'] = value ? 'True' : 'False'
      end
    end
  end
end
