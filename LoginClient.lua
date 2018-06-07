addEventHandler("onClientResourceStart", resourceRoot,
	function()
	
		local screenWidth, screenHeight = guiGetScreenSize()
		local width, height = 640, 480
	
		local window = exports.webui:createWebWindow(0, 0, screenWidth, screenHeight, "http://mta/loginpanel/html/site.html", true)
		
		showCursor(true)
	end
)

function clientClickLogin (msg)
	outputChatBox("elo "..msg)
end
addEvent("eloelo", true)
addEventHandler("eloelo", root, clientClickLogin)