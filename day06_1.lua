local utils = require("util")

local lines = utils.split_string(utils.read_multiline_input(), "\n")

local guard_pos = { i = 0, j = 0 }
local map = {}
local seen = {}

for i, line in pairs(lines) do
	map[i] = {}
	seen[i] = {}
	for j = 1, #line do
		local char = line:sub(j, j)
		map[i][j] = char
		seen[i][j] = 0
		if char == "^" or char == "v" or char == ">" or char == "<" then
			seen[i][j] = 1
			guard_pos.i = i
			guard_pos.j = j
		end
	end
end

local function printMap()
	for i = 1, #map do
		local row = ""
		for j = 1, #map[i] do
			row = row .. map[i][j]
		end
		print(row)
	end
	print("-----")
end

printMap()

-- 1 up 2 right 3 down 4 left
local function guardFace()
	local char = map[guard_pos.i][guard_pos.j]
	print("guard facing" .. char)
	if char == "^" then
		return 1
	elseif char == ">" then
		return 2
	elseif char == "v" then
		return 3
	elseif char == "<" then
		return 4
	end
end

local function setGuardFace(direction)
	local char
	if direction == 1 then
		char = "^"
	elseif direction == 2 then
		char = ">"
	elseif direction == 3 then
		char = "v"
	elseif direction == 4 then
		char = "<"
	end
	map[guard_pos.i][guard_pos.j] = char
end

-- 1 up 2 right 3 down 4 left
local function moveGuard(direction)
	local tmp = map[guard_pos.i][guard_pos.j]
	if direction == 1 then
		map[guard_pos.i][guard_pos.j] = map[guard_pos.i - 1][guard_pos.j]
		map[guard_pos.i - 1][guard_pos.j] = tmp
		guard_pos.i = guard_pos.i - 1
	end
	if direction == 2 then
		map[guard_pos.i][guard_pos.j] = map[guard_pos.i][guard_pos.j + 1]
		map[guard_pos.i][guard_pos.j + 1] = tmp
		guard_pos.j = guard_pos.j + 1
	end
	if direction == 3 then
		map[guard_pos.i][guard_pos.j] = map[guard_pos.i + 1][guard_pos.j]
		map[guard_pos.i + 1][guard_pos.j] = tmp
		guard_pos.i = guard_pos.i + 1
	end
	if direction == 4 then
		map[guard_pos.i][guard_pos.j] = map[guard_pos.i][guard_pos.j - 1]
		map[guard_pos.i][guard_pos.j - 1] = tmp
		guard_pos.j = guard_pos.j - 1
	end
	seen[guard_pos.i][guard_pos.j] = 1
end

-- 1 up 2 right 3 down 4 left
-- if exits the map return 1
local function getNextPlace(direction)
	if direction == 1 then
		if guard_pos.i == 1 then
			return 1
		end
		return map[guard_pos.i - 1][guard_pos.j]
	end
	if direction == 2 then
		if guard_pos.j == #map[guard_pos.i] then
			return 1
		end
		return map[guard_pos.i][guard_pos.j + 1]
	end
	if direction == 3 then
		if guard_pos.i == #map then
			return 1
		end
		return map[guard_pos.i + 1][guard_pos.j]
	end
	if direction == 4 then
		if guard_pos.j == 1 then
			return 1
		end
		return map[guard_pos.i][guard_pos.j - 1]
	end
end

while true do
	local direction = guardFace()
	print("guard is at " .. guard_pos.i .. " " .. guard_pos.j)
	local nextPlace = getNextPlace(direction)
	if nextPlace == 1 then
		break
	end
	print("next place is " .. nextPlace)
	if nextPlace == "#" then
		direction = direction + 1
		if direction == 5 then
			direction = 1
		end
		setGuardFace(direction)
		goto continue
	end
	moveGuard(direction)
	-- printMap()
	::continue::
end

local count = 0
for i = 1, #seen do
	for j = 1, #seen[i] do
		if seen[i][j] == 1 then
			count = count + 1
		end
	end
end

print(count)
