-- Player object is instance of player who have some conditions (fields).

Player = {}
Player.__index = Player

local objects = {} -- list of objects references

-- constructor
function Player:new(id, plr, cash, skin)
	local new = {} -- new object
	setmetatable(new,Player) -- assigning the object to the Player class
	new.identifier = #objects + 1 -- identifier of instance (reference)

	new.id = id;
	new.thisPlayer = plr;
	new.cash = cash;
	new.skin = skin;
	setElementData(plr, "instance:identifier", new.identifier);
	setElementData(plr, "instance", new);
	setElementData(plr, "dbid", id);

	objects[new.identifier] = new;
	return new
end

-- destructor
function Player:destruct()
	table.remove(objects, self.identifier);
end

function Player:giveMoney(amount)
	exports.DB:zapytanie("UPDATE players SET cash=cash+? WHERE dbid=? LIMIT 1", amount, self.id);
	local response = exports.DB:pobierzWyniki("SELECT cash FROM players WHERE dbid=? LIMIT 1", self.id);
	self.cash = response.cash;
end

function Player:takeMoney(amount)
	exports.DB:zapytanie("UPDATE players SET cash=cash-? WHERE dbid=? LIMIT 1", amount, self.id);
	local response = exports.DB:pobierzWyniki("SELECT cash FROM players WHERE dbid=? LIMIT 1", self.id);
	self.cash = response.cash;
end