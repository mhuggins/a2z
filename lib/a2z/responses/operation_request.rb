module A2z
  module Responses
    class OperationRequest
      attr_accessor :request_id, :request_processing_time, :headers, :arguments
      
      def initialize
        @headers = []
        @arguments = []
      end
      
      def self.from_response(data)
        new.tap do |operation_request|
          operation_request.request_id = data['RequestId']
          operation_request.request_processing_time = data['RequestProcessingTime'].to_f
          
          if data['HTTPHeaders']
            headers = data['HTTPHeaders']['Header']
            headers = [headers] unless headers.kind_of?(Array)
            headers = headers.collect { |h| [ h['Name'], h['Value'] ] }
            operation_request.headers = Hash[headers]
          end
          
          if data['Arguments']
            arguments = data['Arguments']['Argument']
            arguments = [arguments] unless arguments.kind_of?(Array)
            arguments = arguments.collect { |a| [ a['Name'], a['Value'] ] }
            operation_request.arguments = Hash[arguments]
          end
          
          operation_request.freeze
        end
      end
    end
  end
end
