# playhaven.trackPurchase(product, quantity)

> --------------------- ------------------------------------------------------------------------------------------
> __Type__              [function][api.type.function]
> __Library__           [playhaven.*][playhaven]
> __Return value__      [boolean][api.type.boolean]
> __Revision__          [REVISION_LABEL](REVISION_URL)
> __Keywords__          
> __Sample code__       
> __See also__          
> --------------------- ------------------------------------------------------------------------------------------


## Overview

The PlayHaven Android SDK supports "virtual good promotion" (or VGP) which allows you to advertise virtual products available within a game. For example, your puzzle game may offer additional levels or special "skins" for a nominal fee. 

## Syntax

	playhaven.trackPurchase( product, quantity )

##### product ~^(required)^~
_[table][api.type.table]._ The product purchased.See **Format for product** below.

##### quantity ~^(optional)^~
_[number][api.type.number]._ The quantity of the purchased product.


### Format for `product`

The `product` table contains the following properties:

##### productIdentifier ~^(required)^~
_[string][api.type.string]._ The product identifier.

##### state ~^(required)^~
_[string][api.type.string]._ The purchase state. IE: purchased or failed.

##### receipt ~^(optional)^~
_[string][api.type.string]._ The receipt from the purchase.

## Examples

``````lua

local playhaven = require "plugin.playhaven"

local playhavenListener = function(event)
	if event.data then
		event.data = json.decode(event.data)
	end
	
	-- Virtual Good handling
	if event.status == "shouldMakePurchase" then
		iap.purchase(event.data.productIdentifier, tonumber(event.data.quantity or 1), function(transaction)
			local transaction_data = {
				productIdentifier = transaction.productIdentifier,
				state = transaction.state,
				receipt = transaction.receipt or ""
			}
			playhaven.trackPurchase(transaction_data, tonumber(event.data.quantity or 1))
		end)
	end
end

local init_options = {
	token = "YOUR_PLAYHAVEN_TOKEN",
	secret = "YOUR_PLAYHAVEN_SECRET",
	closeButton = system.pathForFile("closeButton.png", system.ResourceDirectory),
	closeButtonTouched = system.pathForFile("closeButtonTouched.png", system.ResourceDirectory)
}
playhaven.init(playhavenListener, init_options)


playhaven.contentRequest("virtual_goods", true)
``````
