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
			
			local exists = exports.DB:pobierzWyniki("SELECT dbid FROM players WHERE nick=? LIMIT 1",nickname);
			
			if exists then
				triggerClientEvent(client, "evc", resourceRoot, "error", "This nickname is already exist in database.");
				return;
			end
			
			local _, success = exports.DB:zapytanie("INSERT INTO players SET nick=?,password=SHA1(CONCAT(LOWER(?),'cbF0NdGo',?)), last_session=NOW()",nickname,string.format("%s%s",password,"89dXhg5dOY"),password);
			
			if not success then
				triggerClientEvent(client, "evc", resourceRoot, "error", "This nickname is already exist in database.");
				return;
			end
			
			triggerClientEvent(client, "evc", resourceRoot, "accept", "Registration was successful. Let\\'s login.");
			
		elseif (ev == "verifyLoginData") then
		
			local nickname = arg1;
			local password = arg2;
			
			if (string.len(nickname) < 1) or (string.len(password) < 1) then
				triggerClientEvent(client, "evc", resourceRoot, "error_login", "You have to fill all fields.");
				return;
			end
			
			if (string.len(nickname) > 22) or (string.len(password) > 32) then
				triggerClientEvent(client, "evc", resourceRoot, "error_login", "There are too long values in fields.");
				return;
			end
			
			local exists = exports.DB:pobierzWyniki("SELECT * FROM players WHERE nick=? AND password=SHA1(CONCAT(LOWER(?),'cbF0NdGo',?)) LIMIT 1",nickname,string.format("%s%s",password,"89dXhg5dOY"),password);
			
			if not exists then
				triggerClientEvent(client, "evc", resourceRoot, "error_login", "You try use wrong nickname or wrong password.");
				return;
			end
			
			exports.DB:zapytanie("UPDATE players SET last_session=NOW() WHERE dbid=? LIMIT 1", exists.dbid);
			triggerClientEvent(client, "evc", resourceRoot, "accept_login", "Login was successful.");
			
		end
	end
)