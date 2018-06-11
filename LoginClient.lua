
local window = nil;

addEventHandler("onClientResourceStart", resourceRoot,
	function()
	
		local screenWidth, screenHeight = guiGetScreenSize()
		local width, height = 640, 480
	
		local windowIdentifier = exports.webui:createWebWindow(0, 0, screenWidth, screenHeight, "http://mta/loginpanel/html/site.html", true)
		window = exports.webui:getWebWindowTexture(windowIdentifier); 
		
		showCursor(true)
	end
)

addEvent("cefEventsLoginPanel",true)
addEventHandler("cefEventsLoginPanel", root,
	function(ev, arg1, arg2, arg3, arg4)
		if (ev == "verifyData") then
			local nickname = arg1;
			local password = arg2;
			local confirmPassword = arg3;
			local agreeRules = arg4;
			triggerServerEvent("ev",resourceRoot,ev,nickname,password,confirmPassword,agreeRules)
		end
	end
)

addEvent("evc",true)
addEventHandler("evc",resourceRoot,
	function(ev, arg1)
		if (ev == "error") then
			local message = arg1;
			executeBrowserJavascript(window, "document.getElementById('registration-label').innerHTML = '"..message.."'");
			executeBrowserJavascript(window, "document.getElementById('registration-label').style.color = 'red'");
		elseif (ev == "accept") then
			local message = arg1;
			executeBrowserJavascript(window, "document.getElementById('registration-label').innerHTML = '"..message.."'");
			executeBrowserJavascript(window, "document.getElementById('registration-label').style.color = 'green'");
		end
	end
)