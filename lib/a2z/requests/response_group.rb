module A2z
  module Requests
    class ResponseGroup < BlankSlate
      attr_reader :params
      
      def initialize(value, &block)
        value = value.join(',') if value.kind_of?(Array)
        @params = { 'ResponseGroup' => value }
        instance_eval(&block) if block_given?
      end
      
      def related_item_page(value)
        @params['RelatedItemPage'] = value
      end
      
      def relationship_type(value)
        @params['RelationshipType'] = value
      end
    end
  end
end
