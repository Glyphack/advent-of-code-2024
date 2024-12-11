local utils = require("util")

local lines = utils.split_string(utils.read_multiline_input(), "\n")

local guard = { i = 0, j = 0, direction = 0 }
local map = {}
local seen = {}

-- 1 up 2 right 3 down 4 left
local function guardFace(char)
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

local function tableContains(t, value)
	for _, v in ipairs(t) do
		if v.i == value.i and v.j == value.j and v.direction == value.direction then
			return true
		end
	end
	return false
end

for i, line in pairs(lines) do
	map[i] = {}
	seen[i] = {}
	for j = 1, #line do
		local char = line:sub(j, j)
		map[i][j] = char
		seen[i][j] = 0
		if char == "^" or char == "v" or char == ">" or char == "<" then
			seen[i][j] = 1
			guard.i = i
			guard.j = j
			guard.direction = guardFace(char)
		end
	end
end

printMap()

-- 1 up 2 right 3 down 4 left
local function moveGuard(direction)
	if direction == 1 then
		guard.i = guard.i - 1
	end
	if direction == 2 then
		guard.j = guard.j + 1
	end
	if direction == 3 then
		guard.i = guard.i + 1
	end
	if direction == 4 then
		guard.j = guard.j - 1
	end
end

-- 1 up 2 right 3 down 4 left
-- if exits the map return 1
local function getNextPlace(direction)
	if direction == 1 then
		if guard.i == 1 then
			return 1
		end
		return map[guard.i - 1][guard.j]
	end
	if direction == 2 then
		if guard.j == #map[guard.i] then
			return 1
		end
		return map[guard.i][guard.j + 1]
	end
	if direction == 3 then
		if guard.i == #map then
			return 1
		end
		return map[guard.i + 1][guard.j]
	end
	if direction == 4 then
		if guard.j == 1 then
			return 1
		end
		return map[guard.i][guard.j - 1]
	end
end

local cycles = 0

local originalGuard = utils.deepcopy(guard)

while true do
	local direction = guard.direction
	local nextPlace = getNextPlace(direction)
	if nextPlace == 1 then
		break
	end
	if nextPlace == "#" then
		direction = direction + 1
		if direction == 5 then
			direction = 1
		end
		guard.direction = direction
		goto continue
	end
	moveGuard(direction)
	seen[guard.i][guard.j] = 1
	::continue::
end
guard = utils.deepcopy(originalGuard)

utils.printTable(originalGuard)

local guardPosBackup = { i = guard.i, j = guard.j, direction = guard.direction }

for i = 1, #map do
	for j = 1, #map[i] do
		local originalMap = map[i][j]
		local seenAndDirection = {}
		if seen[i][j] == 0 or (i == guard.i and j == guard.j) or (map[i][j] == "#") then
			goto continue2
		end
		map[i][j] = "#"
		print("trying " .. i .. " " .. j)
		while true do
			local direction = guard.direction
			local nextPlace = getNextPlace(direction)
			if nextPlace == 1 then
				break
			end
			while nextPlace == "#" do
				direction = (direction % 4) + 1
				guard.direction = direction
				nextPlace = getNextPlace(direction)
			end
			if tableContains(seenAndDirection, { i = guard.i, j = guard.j, direction = guard.direction }) then
				print("cycle")
				cycles = cycles + 1
				break
			end
			table.insert(seenAndDirection, { i = guard.i, j = guard.j, direction = guard.direction })
			moveGuard(direction)
		end
		map[i][j] = originalMap
		guard.i, guard.j, guard.direction = guardPosBackup.i, guardPosBackup.j, guardPosBackup.direction
		::continue2::
	end
end

print(cycles)
