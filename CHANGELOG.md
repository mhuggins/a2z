## A2z 0.1.2 (Unreleased)

* Add `most_gifted`, `most_wished_for`, `new_releases`, and `top_sellers`
  accessors on `BrowseNode`, populating them when present in a browse node
  lookup response. *Matt Huggins*

* Fix issue with offer summary parsing the wrong node for `lowest_used_price`.
  *Matt Huggins*

## A2z 0.1.1 (Jan 3, 2012)

* Add `offers` and `offer_summary` accessors on `Item`, populating them when
  present in an item lookup or item search API response. *Matt Huggins*

## A2z 0.1.0 (Jan 3, 2012)

* Add `editorial_reviews` accessor on `Item`, populating them when present in
  an item lookup or item search API response. *Matt Huggins*

* Fix issue with browse node response data being empty. *Matt Huggins*

## A2z 0.0.4 (Jan 2, 2012)

* Implement Amazon's BrowseNodeLookup operation, accessible through
  `Client#browse_node_lookup`. *Matt Huggins*

* Remove unintended `valid` accessor on `ItemLookup` and `ItemSearch` response
  objects, favoring the `valid?` method. *Matt Huggins*

* Accept a string or an array for ResponseGroup value when initializing via
  `ItemLookup#response_group` or `ItemSearch#response_group`. *Matt Huggins*

## A2z 0.0.3 (Dec 30, 2012)

* Add `small_image`, `medium_image`, and `large_image` accessors on `Item`,
  populating them when present in an item lookup or item search API response.
  *Matt Huggins*

* Add `image_sets` accessor on `Item`, populating them when present in an item
  lookup or item search API response. *Matt Huggins*

* Add `Item#parent_asin` method to retrieve ASIN for parent item when
  available. *Matt Huggins*

* Create this change log file. *Matt Huggins*

## A2z 0.0.2 (Dec 29, 2012)

* Create `Item#keys` method & dynamic boolean methods to check for item
  attribute existence. *Matt Huggins*

## A2z 0.0.1 (Dec 27, 2012)

* Initial release. *Matt Huggins*
