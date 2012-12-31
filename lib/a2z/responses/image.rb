module A2z
  module Responses
    class Image
      attr_accessor :url, :width, :height
      
      def width=(value)
        @width = value.to_i
      end
      
      def height=(value)
        @height = value.to_i
      end
      
      def self.from_response(data)
        new.tap do |image|
          image.url = data['URL']
          image.width = data['Width']
          image.height = data['Height']
          image.freeze
        end
      end
    end
  end
end
