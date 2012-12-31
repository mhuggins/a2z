module A2z
  module Responses
    class ImageSet
      include Helpers
      
      attr_accessor :category, :images
      
      def initialize
        @images = {}
      end
      
      def self.from_response(data)
        new.tap do |image_set|
          image_set.category = data['Category']
          
          data.each_pair do |key, value|
            if key =~ /\A(.+)Image\z/
              name = underscore($1).to_sym
              image_set.images[name] = Image.from_response(value)
            end
          end

          image_set.freeze
        end
      end
    end
  end
end
