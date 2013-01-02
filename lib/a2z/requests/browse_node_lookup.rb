module A2z
  module Requests
    class BrowseNodeLookup
      attr_reader :params
      
      def initialize(id, &block)
        @params = { 'Operation' => 'BrowseNodeLookup', 'BrowseNodeId' => id }
        instance_eval(&block) if block_given?
      end
      
      def response_group(value, &block)
        response_group = ResponseGroup.new(value, &block)
        @params.merge!(response_group.params)
      end
    end
  end
end
