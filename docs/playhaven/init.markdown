# playhaven.init(listener, options)

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

Initialize the plugin against the PlayHaven servers. The plugin must be initialized before any other function calls can be made.

## Syntax

	playhaven.init( listener, options )

##### listener ~^(required)^~
_[function][api.type.function]._ The plugin listener. See **Function Details for listener** below.

##### options ~^(optional)^~
_[table][api.type.table]._ A lua table containing the init options. See **Format for options** below.

### Function Details for `listener`

The listener must accept a table as argument. The format of the event table is:

##### status
_[string][api.type.string]._ An event status or name. Possible events:
> requestSucceeded
>
> requestFailed
>
> > Includes message. See **message** below.
>
> didFail
>
> > Includes message. See **message** below.
>
> contentDidFail
>
> > Includes message. See **message** below.
>
> shouldMakePurchase
>
> > Includes data. See **data** below. Possible fields:
>
> > > productIdentifier
>
> > > quantity
>
> unlockedReward
>
> > Includes data. See **data** below. Possible fields:
>
> > > name
>
> > > quantity
>
> willGetContent
>
> willDisplayContent
>
> didDisplayContent
>
> didMissContent

##### message
_[string][api.type.string]._ A string containing any event messages. In case of error event, the message field is populated with the error message.

##### data
_[string][api.type.string]._ A JSON formatted string containing event specific data. String needs to be json.decoded.

### Format for `options`

The `options` table contains the following properties:

##### token ~^(required)^~
_[string][api.type.string]._ Your PlayHaven app token.

##### secret ~^(required)^~
_[string][api.type.string]._ Your PlayHaven app secret.

##### closeButton ~^(optional)^~
_[string][api.type.string]._ Name of image asset to use for customizing the close button image.

##### closeButtonTouch ~^(optional)^~
_[string][api.type.string]._ Name of image asset to use for customizing the close button touch image.

## Examples

``````lua

local playhaven = require("plugin.playhaven")


local playhavenListener = function(event)
end

local init_options = {
	token = "YOUR_PLAYHAVEN_TOKEN",
	secret = "YOUR_PLAYHAVEN_SECRET",
	closeButton = system.pathForFile("closeButton.png", system.ResourceDirectory),
	closeButtonTouched = system.pathForFile("closeButtonTouched.png", system.ResourceDirectory)
}

playhaven.init(playhavenListener, init_options)

``````
