# playhaven.setNotificationBadge(options)

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

Displays a small badge with a number indicating the number of new games a user can view.

## Syntax

	playhaven.setNotificationBadge( options )

##### options ~^(required)^~
_[table][api.type.table]._ A lua table containing the options. See **Format for options** below.


### Format for `options`

The `options` table contains the following properties:

##### x ~^(required)^~
_[number][api.type.number]._ The x coordinate of the badge.

##### y ~^(required)^~
_[number][api.type.number]._ The y coordinate of the badge.

##### placement ~^(required)^~
_[string][api.type.string]._ The placement to get the badge for, usually more_games.

##### clear ~^(optional)^~
_[boolean][api.type.boolean]._ Set clear to true if you want the clear the badge.

##### test ~^(optional)^~
_[boolean][api.type.boolean]._ Set test to true if you want to render the badge independently from any values received from the PlayHaven servers.

##### orientation ~^(optional)^~
_[string][api.type.string]._ A string containing the current device orientation. Rotates the notification badge accordingly.

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

playhaven.setNotificationBadge({x=someButton.x, y=someButton.y, clear=false, test=false, placement="more_games", orientation=system.orientation})

``````
