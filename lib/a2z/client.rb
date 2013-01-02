require 'jeff'
require 'crack/xml'

module A2z
  class Client
    ErrorResponse = Class.new(ArgumentError)
    
    include Jeff
    
    attr_reader :country, :tag
    
    HOSTS = {
        ca: 'ecs.amazonaws.ca',
        cn: 'webservices.amazon.cn',
        de: 'ecs.amazonaws.de',
        es: 'webservices.amazon.es',
        fr: 'ecs.amazonaws.fr',
        it: 'webservices.amazon.it',
        jp: 'ecs.amazonaws.jp',
        uk: 'ecs.amazonaws.co.uk',
        us: 'ecs.amazonaws.com',
    }.freeze
    
    params 'AssociateTag' => -> { tag },
           'Service'      => 'AWSECommerceService',
           'Version'      => '2011-08-01'
    
    def initialize(opts = {})
      self.country  = opts.fetch(:country, :us)
      self.key      = opts[:key]
      self.secret   = opts[:secret]
      self.tag      = opts[:tag]
    end
    
    def country=(code)
      raise ArgumentError.new("Country code must be one of #{HOSTS.keys.join(', ')}.") if code.nil? || HOSTS[code.to_sym].nil?
      @country = code.to_sym
      @endpoint = "http://#{HOSTS[@country]}/onca/xml"
    end
    
    def item_search(&block)
      response = request(Requests::ItemSearch.new(&block))
      Responses::ItemSearch.from_response(response)
    end
    
    def item_lookup(&block)
      response = request(Requests::ItemLookup.new(&block))
      Responses::ItemLookup.from_response(response)
    end
    
    def browse_node_lookup(id, &block)
      response = request(Requests::BrowseNodeLookup.new(id, &block))
      Responses::BrowseNodeLookup.from_response(response)
    end
    
    private
    
    def tag=(tag)
      @tag = tag
    end
    
    def request(req)
      response = get(query: req.params)
      response = Crack::XML.parse(response.body)
      
      # strip the root xml node
      response.values.first
    end
  end
end
