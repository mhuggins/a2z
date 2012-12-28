module A2z
  module Requests
    class ItemLookup < BlankSlate
      include Helpers
      
      attr_reader :params
      
      def initialize(&block)
        @params = { 'Operation' => 'ItemLookup' }
        instance_eval(&block) if block_given?
      end
      
      %w(Condition IdType MerchantId TruncateReviewsAt VariationPage).each do |param|
        method = underscore(param)
        
        class_eval <<-END, __FILE__, __LINE__
          def #{method}(value)
            @params['#{param}'] = value
          end
        END
      end
      
      def id(value)
        value = value.join(',') if value.kind_of?(Array)
        @params['ItemId'] = value
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
