-- Platforms
simulator = system.getInfo("environment") == "simulator"
ios = system.getInfo("platformName") == "iPhone OS" or iPhone or iPod or iPad
android = system.getInfo("platformName") == "Android" or not ios

-- Misc
local widget = require("widget")
local playHaven = require("plugin.playhaven")
local json = require("json")
local iap = require("iap")

iap.initialize()

display.setStatusBar(display.HiddenStatusBar)

local init, doContentRequest

local function digitize(val, len)
	local len = len or 2
	local val = tostring(val)
	while #val < len do
		val = "0" .. val
	end
	return val
end

--******************* GUI *******************--

local background = display.newImage("assets/carbonfiber.jpg", true) -- flag overrides large image downscaling
background.x = display.contentWidth * 0.5
background.y = display.contentHeight * 0.5

local statusText = native.newTextBox( 10, display.contentHeight * 0.5 + 50, display.contentWidth - 20, display.contentHeight * 0.5 - 60 )

updateStatusText = function(txt, plain)
	if plain then
		statusText.text = txt .. "\n" .. statusText.text
	else
		local date = os.date ("*t")
		local datestr = digitize(date.hour, 2) .. ":" .. digitize(date.min, 2) .. ":" .. digitize(date.sec, 2)
		statusText.text = datestr .. " • " .. txt .. "\n" .. statusText.text
	end
end

local button1 = widget.newButton
{
	defaultFile = "assets/buttonRed.png",
	overFile = "assets/buttonRedOver.png",
	label = "Content Request",
	emboss = true,
	fontSize = 10,
	onPress = function(event) doContentRequest("content_request") end
}
button1.x = 160; button1.y = 20

local button2 = widget.newButton
{
	defaultFile = "assets/buttonRed.png",
	overFile = "assets/buttonRedOver.png",
	label = "Toggle Notification Badge",
	emboss = true,
	fontSize = 10,
	onPress = function(event) toggleNotificationBadge() end
}
button2.x = 160; button2.y = button1.y + button1.height + 5

local button3 = widget.newButton
{
	defaultFile = "assets/buttonRed.png",
	overFile = "assets/buttonRedOver.png",
	label = "Virtual Good",
	emboss = true,
	fontSize = 10,
	onPress = function(event) doContentRequest("virtual_good") end
}
button3.x = 160; button3.y = button2.y + button2.height + 5

local button4 = widget.newButton
{
	defaultFile = "assets/buttonRed.png",
	overFile = "assets/buttonRedOver.png",
	label = "More Games Widget",
	emboss = true,
	fontSize = 10,
	onPress = function(event) doContentRequest("more_games") end
}
button4.x = 160; button4.y = button3.y + button3.height + 5

local button5 = widget.newButton
{
	defaultFile = "assets/buttonRed.png",
	overFile = "assets/buttonRedOver.png",
	label = "Announcement",
	emboss = true,
	fontSize = 10,
	onPress = function(event) doContentRequest("announcement") end
}
button5.x = 160; button5.y = button4.y + button4.height + 5

local button6 = widget.newButton
{
	defaultFile = "assets/buttonRed.png",
	overFile = "assets/buttonRedOver.png",
	label = "Reward",
	emboss = true,
	fontSize = 10,
	onPress = function(event) doContentRequest("reward") end
}
button6.x = 160; button6.y = button5.y + button5.height + 5

local button7 = widget.newButton
{
	defaultFile = "assets/buttonRed.png",
	overFile = "assets/buttonRedOver.png",
	label = "Interstitial",
	emboss = true,
	fontSize = 10,
	onPress = function(event) doContentRequest("interstitial") end
}
button7.x = 160; button7.y = button6.y + button6.height + 5

local button8 = widget.newButton
{
	defaultFile = "assets/buttonRed.png",
	overFile = "assets/buttonRedOver.png",
	label = "Data Collection",
	emboss = true,
	fontSize = 10,
	onPress = function(event) doContentRequest("data_collection") end
}
button8.x = 160; button8.y = button7.y + button7.height + 5


--******************************************************--
--****************** PlayHaven Functions ***************--

local function listener(event)
	if event.data then
		event.data = json.decode(event.data)
	end
	
	if event.data then
		updateStatusText("--------------", true)
		updateStatusText(json.encode(event.data), true)
		updateStatusText(event.status)
	else
		updateStatusText(event.status)
	end
	
	-- Reward handling
	if event.status == "unlockedReward" then
		-- event.data contains:
		-- • name
		-- • quantity
		native.showAlert("Congratulations!", "You got a free reward, " .. event.data.quantity .. " piece of " .. event.data.name .. "!", {"OK"})
	end
	
	-- Virtual Good handling
	if event.status == "shouldMakePurchase" then
		-- event.data contains:
		-- • productIndentifier
		-- • quantity
		if ios then
			iap.purchase(event.data.productIdentifier, tonumber(event.data.quantity or 1), function(transaction)
				local transaction_data = {
					productIdentifier = transaction.productIdentifier,
					state = transaction.state,
					receipt = transaction.receipt or ""
				}
				playHaven.trackPurchase(transaction_data, tonumber(event.data.quantity or 1))
			end)
		else
			local transaction_data = {
				productIdentifier = event.data.productIdentifier,
				state = "purchased",
				receipt = ""
			}
			playHaven.trackPurchase(transaction_data, tonumber(event.data.quantity or 1))
		end
	end
end

local init_options = {}
if ios then
	init_options = {
	   	token = "617f4489f5844039aa539c07291d8cb3",
	    secret = "c7f531f7b6af4f7d8a8a8d59eaea0a91",
		--closeButton = system.pathForFile("closeButton.png", system.ResourceDirectory),
		--closeButtonTouched = system.pathForFile("closeButtonTouched.png", system.ResourceDirectory),
		--customUDID = "myCustomUDID",
		--optOut = true
	}
elseif android then
	init_options = {
		token = "51d30ff4121f4670aecd805584f11209",
		secret = "8b00cee8c97049ad967ee3990c4421de",
		closeButton = system.pathForFile("closeButton.png", system.ResourceDirectory),
		closeButtonTouched = system.pathForFile("closeButtonTouched.png", system.ResourceDirectory),
		optOut = false
	}
end

init = function()
	updateStatusText("Initializing PlayHaven")
	playHaven.init(listener, init_options)
end

doContentRequest = function(placement)
	updateStatusText("Content Request called: " .. placement)
	playHaven.contentRequest(placement, true)
end

local notificationOn = false
toggleNotificationBadge = function()
	local bX = button2.x + button2.contentWidth * 0.5 - 12
	local bY = button2.y - button2.contentHeight * 0.5 + 12
	if notificationOn then
		notificationOn = false
		playHaven.setNotificationBadge({clear=true})
		updateStatusText("Clear notification badge")
	else
		notificationOn = true
		playHaven.setNotificationBadge({x=bX, y=bY, orientation=system.orientation, clear=false, test=true, placement="more_games"})
		updateStatusText("Set notification badge")
	end
end

-- Init PlayHaven
timer.performWithDelay(1000, function() 
	init()
end)

updateStatusText("Welcome to PlayHaven!")

--*************** Orientation *****************--

local initialOrientation = system.orientation
local function onOrientationChange(event)
	if notificationOn then

		local bX = button2.x + button2.contentWidth * 0.5 - 12
		local bY = button2.y - button2.contentHeight * 0.5 + 12
		playHaven.setNotificationBadge({x=bX, y=bY, clear=true, test=true, placement="more_games", orientation=event.type})
		updateStatusText("Reset notification badge")
	
	end
	
	if event.type == "portraitUpsideDown" then
		
	end
	
	if event.type == "portrait" and iPad then
		
	end
	
	if event.type == "landscapeLeft" then
		
	end
	
	if event.type == "landscapeRight" then
		
	end

end
Runtime:addEventListener("orientation", onOrientationChange)

--***************** Resume ********************--

local function onSystemEvent(event)
	if event.type == "applicationResume" then
		updateStatusText("Resuming app")
		if ios then
			init()
		end
	end
end
Runtime:addEventListener("system", onSystemEvent)