addEventHandler("onClientResourceStart", resourceRoot,
	function()
	
		local screenWidth, screenHeight = guiGetScreenSize()
		local width, height = 640, 480
	
		local window = exports.webui:createWebWindow(0, 0, screenWidth, screenHeight, "http://mta/loginpanel/html/site.html", true)
		
		showCursor(true)
	end
)

addEvent("cefEventsLoginPanel",true)
addEventHandler("cefEventsLoginPanel", root,
	function(ev, nickname, password, confirmPassword, agreeRules)
		if (ev == "verifyData") then
			triggerServerEvent("ev",resourceRoot,nickname,password,confirmPassword,agreeRules)
		end
	end
)