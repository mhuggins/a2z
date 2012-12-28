# A2z

A2z provides a simple Ruby DSL to retrieve product information from the
[Amazon Product Advertising API](https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html).

## Installation

Add this line to your application's Gemfile:

    gem 'a2z'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install a2z

## Usage

The basis of the A2z gem is the `A2z::Client`.  A client can be used to search
for items or lookup a specific item available on [Amazon](http://www.amazon.com).
Instantiating a client requires an API `key`, `secret`, and `tag`.  To obtain
these, you'll need to [create an Amazon Product Advertising API account](https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html).

Once you have these, create the client as follows:

    client = A2z::Client.new(key: 'YOUR_KEY', secret: 'YOUR_SECRET', tag: 'YOUR_TAG')

By default, a client will search within Amazon US (i.e.: amazon.com).  This can
be customized by passing a `country` option when initializing your client.
Valid country options are `:ca`, `:cn`, `:de`, `:es`, `:fr`, `:it`, `:jp`,
`:uk`, and `:us`.  For example:

    client = A2z::Client.new(country: :us, ...)

Alternative, the country can be changed after the client has been initialized.

    client.country = :us

Within a Rails application, you'll probably want to keep your key, secret, and
tag information out of source control.  One way to do this is to store this
information in a YAML file such as `config/amazon.yml`.  For example:

    key:    YOUR_KEY
    secret: YOUR_SECRET
    tag:    YOUR_TAG

This file can then be used in the following manner:

    config = YAML.load_file(Rails.root.join('config', 'amazon.yml'))
    client = A2z::Client.new(config)

### Item Search

Once you have instantiated an `A2z::Client` instance, searching for products
can be done through the `item_search` method.

    response = client.item_search do
                 category 'Music'
                 keywords 'Dave Matthews Band'
               end

The return value is an `A2z::Responses::ItemSearch` object.  The example above
would make the following calls possible.

    response.valid?
    => true
    
    response.total_results
    => 435
    
    response.total_pages
    => 44
    
    response.items.size
    => 10
    
    response.items.first
    # => #<A2z::Responses::Item ...>
    
    response.more_search_results_url
    => "http://www.amazon.com/gp/redirect.html?camp=2025&creative=386001&location=..."
    
    response.operation_request
    => #<A2z::Responses::OperationRequest ...>

For more information on interacting with `A2z::Responses::Item` and
`A2z::Responses::OperationRequest` objects, refer to their respective sections
below.

The following code is likely not a real-world example of how you would use
the client to perform a search; it is only intended to demonstrate the full
collection of methods provided when performing an item search.

    client.item_search do
      category 'Books'
      keywords 'Harry Potter'
      actor 'Adam Sandler'
      artist 'Muse'
      audience_rating 'PG-13'
      author 'J.K. Rowling'
      brand 'Timex'
      browse_node 17
      composer 'Wolfgang Amadeus Mozart'
      condition 'Refurbished'
      conductor 'Leopold Stokowski'
      director 'Judd Apatow'
      include_reviews_summary true
      item_page 1
      manufacturer 'Sony'
      merchant_id 'SOME_MERCHANT_ID'
      maximum_price 49.99
      minimum_price 10.50
      min_percentage_off 20
      music_label 'Universal'
      orchestra 'Antonio Vivaldi'
      power 'subject:history and (spain or mexico) and not military and language:spanish'
      publisher 'EMI'
      sort 'inverse-pricerank'
      title 'Harry Potter and the Chamber of Secrets'
      truncate_reviews_at 0
      variation_page 2
      response_group('RelatedItems') do
        related_item_page 2
        relationship_type 'Episode'
      end
    end

Required arguments and argument values vary depending upon how you use the API.
For a full list of arguments and when they are required vs. optional, refer to
Amazon's [ItemSearch documentation](http://docs.amazonwebservices.com/AWSECommerceService/latest/DG/ItemSearch.html).

### Item Lookup

Once you have instantiated an `A2z::Client` instance, looking up a product can
be done through the `item_lookup` method.

    response = client.item_lookup do
                 id '059035342X'
               end

The return value is an `A2z::Responses::ItemLookup` object.  The example above
would make the following calls possible.

    response.valid?
    => true
    
    response.item
    # => #<A2z::Responses::Item ...>
    
    response.operation_request
    => #<A2z::Responses::OperationRequest ...>

For more information on interacting with `A2z::Responses::Item` and
`A2z::Responses::OperationRequest` objects, refer to their respective sections
below.

The following code is likely not a real-world example of how you would use
the client to perform a lookup; it is only intended to demonstrate the full
collection of methods provided when performing an item lookup.

    client.item_lookup do
      category 'Books'
      id '059035342X'
      id_type 'ASIN'
      merchant_id 'SOME_MERCHANT_ID'
      truncate_reviews_at 0
      variation_page 2
      response_group('RelatedItems') do
        related_item_page 2
        relationship_type 'Episode'
      end
    end

Required arguments and argument values vary depending upon how you use the API.
For a full list of arguments and when they are required vs. optional, refer to
Amazon's [ItemLookup documentation](http://docs.amazonwebservices.com/AWSECommerceService/latest/DG/ItemLookup.html).

### Items

Item lookup and item search response objects generally include one or more
`A2z::Responses::Item` objects accessible via the `#item` and `#items`
instance methods, respectively.

For example:

    response = client.item_search { ... }
    => #<A2z::Responses::ItemSearch ...>
    
    item = response.items.first
    => #<A2z::Responses::Item ...>
    
    item.asin
    => "B008FERRFO"
    
    item.title
    => "Away From The World (Deluxe Version)"
    
    item.artist
    => "Dave Matthews Band"
    
    item.detail_page_url
    => ""http://www.amazon.com/Away-From-World-Deluxe-Version/dp/B008FERRFO..."
    
    item.manufacturer
    => "RCA"
    
    item.product_group
    => "Music"

Note that some attributes like `artist` and `manufacturer` are only set
depending upon the type of item.  There is currently no way to determine which
attributes have been set on an item object instance.  This issue will be
addressed in the next gem release.

### Operation Requests

Item lookup and item search response objects include an
`A2z::Responses::OperationRequest` accessible via the `#operation_request`
instance method.

For example:

    response = client.item_lookup { ... }
    => #<A2z::Responses::ItemLookup ...>
    
    response.operation_request.request_id
    => "fc5d5321-a347-4e65-9483-9655e8d9cf16"
    
    response.operation_request.request_processing_time
    => 0.087729
    
    response.operation_request.headers.class
    => Hash
    
    response.operation_request.headers['UserAgent']
    => "Jeff/0.4.3 (Language=Ruby; localhost)"
    
    response.operation_request.arguments.class
    => Hash
    
    response.operation_request.arguments['Operation']
    => "ItemSearch"

## Contributing

This gem is new, and as such is lacking a full feature-set for interacting with
the Product Advertising API.  For example, many of the available
[operations](http://docs.amazonwebservices.com/AWSECommerceService/latest/DG/CHAP_OperationListAlphabetical.html)
have not yet been implemented.

Additionally, not much testing has been done yet, so there are many
combinations of arguments that may result in errors or exceptions being
thrown by the gem.

As such, any and all external help is encouraged and much appreciated!

To contribute:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

A2z is released under the [MIT License](http://www.opensource.org/licenses/MIT).
