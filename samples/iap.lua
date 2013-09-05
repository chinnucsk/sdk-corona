store = require("store")

local iap = {}
local iap_callback = nil
local iap_current_action = nil
local iap_initialized = nil

-- Init
iap.initialize = function()
	local listener = function(event)
		native.setActivityIndicator(false)
		local transaction = event.transaction or event
		
		if transaction.state == "failed" then
			native.showAlert("Transaction failed", transaction.errorString or transaction.errorType or "It just failed", {"OK"})
		end
		
		if iap_callback then 
			iap_callback(transaction) 
		end
		
		store.finishTransaction(transaction)
	end
	
	if android then
		store.init("google", listener)
	else
		store.init(listener)
	end
	iap_initialized = true
end

-- Purchase
iap.purchase = function(product, quantity, callback)
	iap_callback = nil
	local products = {}
	
	if type(product) == "table" then
		product = table.remove(product, 1)
	end
	
	if store.canMakePurchases then
		if callback then
			iap_callback = callback
		end
		native.setActivityIndicator(true)

		iap_current_action = "purchased"
		
		for i=1, quantity do
			table.insert(products, product)
		end
		
		store.purchase(products)
	else
		native.showAlert("Cannot purchase", "Unsupported device", {"OK"})
	end
end

return iap