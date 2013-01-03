module A2z
  module Responses
    class EditorialReview
      attr_accessor :source, :content
      
      def self.from_response(data)
        new.tap do |editorial_review|
          editorial_review.source = data['Source']
          editorial_review.content = data['Content']
          editorial_review.freeze
        end
      end
    end
  end
end
