module A2z
  module Responses
    class BrowseNodeLookup
      attr_accessor :operation_request, :node
      
      def initialize
        @valid = true
      end
      
      def valid=(value)
        @valid = !!value
      end
      
      def valid?
        @valid
      end
      
      # TODO capture data['BrowseNodes']['Request']['Errors'] into an attr_accessor value
      # TODO consider capturing data['BrowseNodes']['Request'] into an attr_accessor value
      def self.from_response(data)
        new.tap do |browse_node_lookup|
          browse_node_lookup.operation_request = OperationRequest.from_response(data['OperationRequest']) if data['OperationRequest']
          browse_node_lookup.node = BrowseNode.from_response(data['BrowseNodes']['BrowseNode'])
          browse_node_lookup.valid = data['BrowseNodes']['Request']['IsValid'] == 'True' rescue false
          browse_node_lookup.freeze
        end
      end
    end
  end
end
