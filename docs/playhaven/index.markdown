# playhaven.*

> --------------------- ------------------------------------------------------------------------------------------
> __Type__              [library][api.type.library]
> __Revision__          [REVISION_LABEL](REVISION_URL)
> __Keywords__          PlayHaven
> __Sample code__       
> __See also__          
> __Availability__      Pro, Enterprise
> --------------------- ------------------------------------------------------------------------------------------

## Overview

Use PlayHaven to maximize your games LTV.

## Sign Up

To use PlayHaven, please [sign up](http://www.playhaven.com) for an account.

## Platforms

* Android: Yes
* iOS: Yes
* Mac: No
* Win: No
* Kindle: No
* NOOK: No

## Syntax

	local playhaven = require "plugin.playhaven"

## Functions

#### [playhaven.init(listener, options)][playhaven.init]
#### [playhaven.contentRequest(placement, show)][playhaven.contentRequest]
#### [playhaven.trackPurchase(product, quantity)][playhaven.trackPurchase]
#### [playhaven.setNotificationBadge(options)][playhaven.setNotificationBadge]

## Project Settings

### SDK

When you build using the Corona Simulator, the server automatically takes care of integrating the plugin into your project. 

All you need to do is add an entry into a `plugins` table of your `build.settings`. The following is an example of a minimal `build.settings` file:

``````
settings =
{
	plugins =
	{
		-- key is the name passed to Lua's 'require()'
		["plugin.playhaven"] =
		{
			-- required
			publisherId = "com.playhaven",
		},
	},		
}
``````

### Enterprise

The source or jar for the PlayHaven plugin is available in the [PlayHaven Corona Plugin github repository](https://github.com/playhaven/sdk-corona-internal/tree/master/submission).

## Sample Code

You can access sample code [here](https://github.com/playhaven/sdk-corona-internal/tree/master/submission/samples).

## Support

More support is available from the PlayHaven team:

* [E-mail](mailto://support@playhaven.com)
* [Forum](http://forum.coronalabs.com/plugin/playhaven)
* [Plugin Publisher](http://p)
