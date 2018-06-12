-- Player object is instance of player who have some conditions (fields).

Player = {}
Player.__index = Player

local objects = {} -- list of objects references

function Player:create()
	local new = {} -- new object
	setmetatable(new,Rock) -- assigning the object to the Player class
	new.identifier = #objects + 1


	objects[new.identifier] = new;
	return new
end