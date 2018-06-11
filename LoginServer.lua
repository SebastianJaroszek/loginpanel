addEvent("ev",true)
addEventHandler("ev",resourceRoot,
	function(ev,arg1,arg2,arg3,arg4)
		if (ev == "verifyData") then
			local nickname = arg1;
			local password = arg2;
			local confirmPassword = arg3;
			local agreeRules = arg4;
			
			if (string.len(nickname) < 1) or (string.len(password) < 1) or (string.len(confirmPassword) < 1) then
				triggerClientEvent(client, "evc", resourceRoot, "error", "You have to fill all fields.");
				return;
			end
			
			if (string.len(nickname) > 22) or (string.len(password) > 32) or (string.len(confirmPassword) > 32) then
				triggerClientEvent(client, "evc", resourceRoot, "error", "There are too long values in fields.");
				return;
			end
			
			if (string.len(password) < 6) then
				triggerClientEvent(client, "evc", resourceRoot, "error", "Password must contains 6 or more characters.");
				return;
			end
			
			if (password ~= confirmPassword) then
				triggerClientEvent(client, "evc", resourceRoot, "error", "Passwords are different.");
				return;
			end
			
			if (tonumber(agreeRules) < 1) then
				triggerClientEvent(client, "evc", resourceRoot, "error", "You have to accept rules and privacy policy.");
				return;
			end
			
			triggerClientEvent(client, "evc", resourceRoot, "accept", "Registration was successful. Let\\'s login.");
			
		end
	end
)