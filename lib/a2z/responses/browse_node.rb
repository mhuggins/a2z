module A2z
  module Responses
    class BrowseNode
      include Helpers
      
      attr_accessor :id, :name, :ancestors, :children, :most_gifted,
                    :most_wished_for, :new_releases, :top_sellers
      
      def initialize
        @ancestors = []
        @children = []
        @most_gifted = []
        @most_wished_for = []
        @new_releases = []
        @top_sellers = []
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
            
            if data['TopItemSet']
              top_item_sets = array_wrap(data['TopItemSet'])
              top_item_sets.each do |top_item_set|
                top_items = array_wrap(top_item_set['TopItem']).collect { |top_item| TopItem.from_response(top_item) }
                
                case top_item_set['Type']
                  when 'MostGifted' then browse_node.most_gifted = top_items
                  when 'MostWishedFor' then browse_node.most_wished_for = top_items
                  when 'NewReleases' then browse_node.new_releases = top_items
                  when 'TopSellers' then browse_node.top_sellers = top_items
                end
              end
            end
          end
          
          browse_node.freeze
        end
      end
    end
  end
end
