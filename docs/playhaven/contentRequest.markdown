# playhaven.contentRequest(placement, show)

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

Displays a fullscreen content unit with the placement specified. Content units include ads, announcements and cross-promotions.

## Syntax

	playhaven.contentRequest( placement, show )

##### placement ~^(required)^~
_[string][api.type.string]._ The placement of the content unit. Placements are created in the PlayHaven backend.

##### show ~^(required)^~
_[boolean][api.type.boolean]._ Set to true to show immediately, or set to false to use the request for preloading the content unit.

## Examples

``````lua

local playhaven = require "plugin.playhaven"

local playhavenListener = function(event)
end

local init_options = {
	token = "YOUR_PLAYHAVEN_TOKEN",
	secret = "YOUR_PLAYHAVEN_SECRET",
	closeButton = system.pathForFile("closeButton.png", system.ResourceDirectory),
	closeButtonTouched = system.pathForFile("closeButtonTouched.png", system.ResourceDirectory)
}
playhaven.init(playhavenListener, init_options)


playhaven.contentRequest("announcement", true)

``````
