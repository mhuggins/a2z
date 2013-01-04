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

### Browse Node Lookup

Once you have instantiated an `A2z::Client` instance, browsing category nodes
can be done through the `browse_node_lookup` method.

    response = client.browse_node_lookup(1000)

The return value is an `A2z::Responses::BrowseNodeLookup` object.  The above
example would make the following calls possible.

    response.valid?                        # => true
    response.operation_request             # => #<A2z::Responses::OperationRequest ...>
    
    node = response.node                   # => #<A2z::Responses::BrowseNode ...>
    node.id                                # => 1000
    node.name                              # => "Subjects"
    node.root?                             # => true
    node.ancestors.size                    # => 1
    node.children.size                     # => 30
    
    ancestor = node.ancestors.first        # => #<A2z::Responses::BrowseNode ...>
    ancestor.id                            # => 283155
    ancestor.name                          # => "Books"
    ancestor.root?                         # => false
    
    child = node.children.first            # => #<A2z::Responses::BrowseNode ...>
    child.id                               # => 1
    child.name                             # => "Arts & Photography"
    child.root?                            # => false

By default, Amazon assumes the response group to be "BrowseNodeInfo".
Additional response groups "MostGifted", "MostWishedFor", "NewReleases", and
"TopSellers" can be requested as well, allowing access to top items per the
following example code.

    node = response.node                   # => #<A2z::Responses::BrowseNode ...>
    
    node.most_gifted.size                  # => 10
    node.most_gifted.first                 # => #<A2z::Responses::TopItem ...>
    
    node.most_wished_for.size              # => 10
    node.most_wished_for.first             # => #<A2z::Responses::TopItem ...>
    
    node.new_releases.size                 # => 10
    node.new_releases.first                # => #<A2z::Responses::TopItem ...>
    
    node.top_sellers.size                  # => 10
    node.top_sellers.first                 # => #<A2z::Responses::TopItem ...>

For more information on interacting with `A2z::Responses::TopItem` and
`A2z::Responses::OperationRequest` objects, refer to their respective sections
below.  With regards to children, only the direct children are included in a
response.  However, ancestors are nested all the way to the top-most parent.

The following code demonstrate the full collection of methods provided when
performing a browse node lookup.

    response = client.browse_node_lookup(1000) do
                 response_group 'TopSellers'
               end

Required arguments and argument values vary depending upon how you use the API.
For a full list of arguments and when they are required vs. optional, refer to
Amazon's [BrowseNodeLookup documentation](http://docs.amazonwebservices.com/AWSECommerceService/latest/DG/BrowseNodeLookup.html).

### Item Search

Once you have instantiated an `A2z::Client` instance, searching for products
can be done through the `item_search` method.

    response = client.item_search do
                 category 'Music'
                 keywords 'Dave Matthews Band'
               end

The return value is an `A2z::Responses::ItemSearch` object.  The example above
would make the following calls possible.

    response.valid?                        # => true
    response.total_results                 # => 435
    response.total_pages                   # => 44
    response.items.size                    # => 10
    response.items.first                   # => #<A2z::Responses::Item ...>
    response.more_search_results_url       # => "http://www.amazon.com/gp/redirect.html?camp=2025&creative=386001..."
    response.operation_request             # => #<A2z::Responses::OperationRequest ...>

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

    response.valid?                        # => true
    response.item                          # => #<A2z::Responses::Item ...>
    response.operation_request             # => #<A2z::Responses::OperationRequest ...>

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

    response = client.item_search { ... }  # => #<A2z::Responses::ItemSearch ...>
    item = response.items.first            # => #<A2z::Responses::Item ...>
    
    item.asin                              # => "B008FERRFO"
    item.keys                              # => ["artist", "manufacturer", "product_group", "title"]
    item.title?                            # => true
    item.artist?                           # => true
    item.manufacturer?                     # => true
    item.product_group?                    # => true
    item.composer?                         # => false
    item.title                             # => "Away From The World (Deluxe Version)"
    item.artist                            # => "Dave Matthews Band"
    item.manufacturer                      # => "RCA"
    item.product_group                     # => "Music"
    
    item.editorial_reviews.size            # => 1
    item.editorial_reviews.first           # => #<A2z::Responses::EditorialReview ...>
    
    item.offers.size                       # => 1
    item.offers.first                      # => #<A2z::Responses::Offer ...>
    item.offer_summary                     # => #<A2z::Responses::OfferSummary ...>
    
    item.detail_page_url                   # => "http://www.amazon.com/Away-From-World-Deluxe-Version/dp/B008FERRFO..."

When an item lookup or item search includes the "Images" response group, items
will also have their `small_image`, `medium_image`, `large_image`, and
`image_sets` attributes populated, assuming they are included in the API
response.

    response = client.item_lookup do
      id 'B008VVEJNE'
      response_group 'Images'
    end
    
    item = response.item
    
    item.small_image                       # => #<A2z::Responses::Image ...>
    item.medium_image                      # => #<A2z::Responses::Image ...>
    item.large_image                       # => #<A2z::Responses::Image ...>
    
    item.image_sets.size                   # => 2
    item.image_sets.keys                   # => [:primary, :variant]
    item.image_sets[:primary]              # => #<A2z::Responses::ImageSet ...>

Refer to the Image Sets and Images sections below for more information on using
these objects.

### Top Items

Top items are accessible on browse nodes when performing browse node lookups
with a response group of "MostGifted", "MostWishedFor", "NewReleases", and
"TopSellers".

    top_item = node.top_sellers.first      # => #<A2z::Responses::TopItem ...>
    top_item.asin                          # => "B00AQ3K8IU"
    top_item.title                         # => "Hopeless"
    top_item.product_group                 # => "eBooks"
    top_item.actor                         # => nil
    top_item.artist                        # => nil
    top_item.author                        # => "Hoover, Colleen"
    top_item.detail_page_url               # => "http://www.amazon.com/Hopeless-ebook/dp/B00AQ3K8IU..."

### Image Sets

Image sets are accessible on items when the "Images" responses group is
included as part of an item lookup or item search request.  Image sets are
relatively simple objects, only including a category name and hash of images
keyed by size.

For example:

    item_set = item.image_sets[:primary]   # => #<A2z::Responses::ImageSet ...>
    item_set.category                      # => "primary"
    item_set.images.keys                   # => [:swatch, :small, :thumbnail, :tiny, :medium, :large]
    item_set.images[:swatch]               # => #<A2z::Responses::Image ...>

Refer to the Images section below for more information on using this objects.

### Images

Images are accessible on items and through item sets when the "Images" response
group is included as part of an item lookup or item search request.  Images
include only vital information, including the URL, width, and height in pixels.

For example:

    response = client.item_lookup do
      id 'B008VVEJNE'
      response_group 'Images'
    end
    
    image = response.item.large_image      # => #<A2z::Responses::Image ...>
    image.url                              # => "http://ecx.images-amazon.com/images/I/411%2BCDuXoSL.jpg"
    image.width                            # => 297
    image.height                           # => 500

### Offers

Offers are accessible on items when the "Offers", "OfferListings", or
"OfferFull" response group is included as part of an item lookup or item search
request.

    offer = item.offers.first              # => #<A2z::Responses::Offer ...>
    
    offer.price                            # => #<Money fractional:699 currency:USD>
    offer.price.format                     # => "$6.99"
    
    offer.amount_saved                     # => #<Money fractional:699 currency:USD>
    offer.amount_saved.format              # => "$6.99"
    
    offer.percentage_saved                 # => 50
    
    offer.listing_id                       # => "oRHYBpasjoYr7hV0Ji5g6wjyJVv4xj1ZKnYRnsLsdzvcYotTARQNNueaVBzRP2CJCq..."
    offer.condition                        # => "New"
    offer.availability                     # => "Usually ships in 24 hours"
    offer.super_saver_shipping_eligible?   # => true

For more help on working with Money objects, refer to the
[RubyMoney gem page](http://rubymoney.github.com/money/).

### Offer Summaries

Offer summaries are accessible on items when the "Offers", "OfferFull", or
"OfferSummary" response group is included as part of an item lookup or item
search request.

    offer_summary = item.offer_summary     # => #<A2z::Responses::OfferSummary ...>
    
    offer_summary.lowest_new_price         # => #<Money fractional:699 currency:USD>
    offer_summary.lowest_used_price        # => #<Money fractional:699 currency:USD>
    
    offer_summary.total_new                # => 28
    offer_summary.total_used               # => 17
    offer_summary.total_collectible        # => 0
    offer_summary.total_refurbished        # => 0

For more help on working with Money objects, refer to the
[RubyMoney gem page](http://rubymoney.github.com/money/).

### Editorial Reviews

Editorial reviews are accessible on items when the "EditorialResponse" response
group is included as part of an item lookup or item search request.  Editorial
response objects only include the source and the content.

    review = item.editorial_reviews.first  # => #<A2z::Responses::EditorialReview ...>
    review.source                          # => "Product Description"
    review.content                         # => "Breakout pop sensation Carly Rae Jepsen releases her..."

### Operation Requests

Item lookup, item search, and browse node lookup response objects include an
`A2z::Responses::OperationRequest` accessible via the `#operation_request`
instance method.

For example:

    response = client.item_lookup { ... }  # => #<A2z::Responses::ItemLookup ...>
    op_req = response.operation_request    # => #<A2z::Responses::OperationRequest ...>
    op_req.request_id                      # => "fc5d5321-a347-4e65-9483-9655e8d9cf16"
    op_req.request_processing_time         # => 0.087729
    op_req.headers.class                   # => Hash
    op_req.headers['UserAgent']            # => "Jeff/0.4.3 (Language=Ruby; localhost)"
    op_req.arguments.class                 # => Hash
    op_req.arguments['Operation']          # => "ItemLookup"

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
