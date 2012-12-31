module A2z
  module Responses
    class Item
      include Helpers
      
      attr_accessor :asin, :parent_asin, :detail_page_url, :links, :image_sets,
                    :small_image, :medium_image, :large_image
      
      def initialize
        @links = []
        @attrs = {}
        @image_sets = {}
      end
      
      def keys
        @attrs.keys
      end
      
      def respond_to_missing?(name, include_private = false)
        name.to_s.end_with?('?') || super
      end
      
      def method_missing(name, *args, &block)
        method_name = name.to_s
        
        if method_name.end_with?('?')  # && method_name != 'has_key?'
          has_key?(method_name.sub(/\?$/, ''))
        elsif has_key?(method_name)
          self[method_name]
        else
          super
        end
      end
      
      def []=(key, value)
        @attrs[key] = value
      end
      
      def [](key)
        @attrs[key]
      end
      
      def has_key?(key)
        @attrs.has_key?(key)
      end
      
      def self.from_response(data)
        new.tap do |item|
          item.asin = data['ASIN']
          item.parent_asin = data['ParentASIN']
          item.detail_page_url = data['DetailPageURL']
          
          if data['ItemLinks']
            item.links = data['ItemLinks']['ItemLink'].collect { |link| ItemLink.from_response(link) }
          end
          
          if data['ItemAttributes']
            data['ItemAttributes'].each { |key, value| item[underscore(key)] = value }
          end
          
          if data['ImageSets'] && data['ImageSets']['ImageSet']
            image_sets = data['ImageSets']['ImageSet']
            image_sets = [image_sets] unless image_sets.kind_of?(Array)
            
            image_sets.each do |image_set|
              image_set = ImageSet.from_response(image_set)
              item.image_sets[image_set.category.to_sym] = image_set
            end
          end
          
          item.small_image = Image.from_response(data['SmallImage']) if data['SmallImage']
          item.medium_image = Image.from_response(data['MediumImage']) if data['MediumImage']
          item.large_image = Image.from_response(data['LargeImage']) if data['LargeImage']
          
          item.freeze
        end
      end
    end
  end
end
