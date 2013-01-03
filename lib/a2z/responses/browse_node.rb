module A2z
  module Responses
    class BrowseNode
      include Helpers
      
      attr_accessor :id, :name, :ancestors, :children
      
      def initialize
        @ancestors = []
        @children = []
        @root = false
      end
      
      def id=(value)
        @id = value.to_i
      end
      
      def root=(value)
        @root = !!value
      end
      
      def root?
        @root
      end
      
      def self.from_response(data)
        new.tap do |browse_node|
          if data
            browse_node.id   = data['BrowseNodeId']
            browse_node.name = data['Name']
            browse_node.root = data['IsCategoryRoot'] == '1' rescue false
            
            if data['Children'] && data['Children']['BrowseNode']
              children = array_wrap(data['Children']['BrowseNode'])
              browse_node.children = children.collect { |child| BrowseNode.from_response(child) }
            end
            
            if data['Ancestors'] && data['Ancestors']['BrowseNode']
              ancestors = array_wrap(data['Ancestors']['BrowseNode'])
              browse_node.ancestors = ancestors.collect { |ancestor| BrowseNode.from_response(ancestor) }
            end
          end
          
          browse_node.freeze
        end
      end
    end
  end
end
