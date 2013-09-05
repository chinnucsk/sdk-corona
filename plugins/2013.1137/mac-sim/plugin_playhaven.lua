local Library = require "CoronaLibrary"

-- Create library
local lib = Library:new{ name='plugin_playhaven', publisherId='com.playhaven' }

-------------------------------------------------------------------------------
-- BEGIN (Insert your implementation starting here)
-------------------------------------------------------------------------------

lib.init = function()
	print( 'PlayHaven Not Supported in Simulator' )
end

lib.contentRequest = function()
	print( 'PlayHaven Not Supported in Simulator' )
end

lib.trackPurchase = function()
	print( 'PlayHaven Not Supported in Simulator' )
end

lib.setNotificationBadge = function()
	print( 'PlayHaven Not Supported in Simulator' )
end

-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------

-- Return an instance
return lib
