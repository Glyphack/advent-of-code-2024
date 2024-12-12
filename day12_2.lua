local utils = require("util")

local input = utils.split_string(utils.read_multiline_input(), "\n")

local map = {}
local seen = {}
local seen_count = 0
local function newPoint(i, j)
	return { i = i, j = j }
end

for i = 1, #input do
	local line = input[i]
	map[i] = {}
	seen[i] = {}
	for j = 1, #line do
		local char = line:sub(j, j)
		map[i][j] = char
		seen[i][j] = false
	end
end
utils.printMap(map)

local function getVal(point)
	return map[point.i][point.j]
end

local function isInMap(point)
	if point.i > #map then
		return false
	end
	if point.j > #map[1] then
		return false
	end
	if point.i < 1 or point.j < 1 then
		return false
	end
	return true
end

local function moveUp(point)
	return newPoint(point.i - 1, point.j)
end

local function moveDown(point)
	return newPoint(point.i + 1, point.j)
end

local function moveLeft(point)
	return newPoint(point.i, point.j - 1)
end

local function moveRight(point)
	return newPoint(point.i, point.j + 1)
end

function GetPerimiter(val, neighbor)
	local perimeter = 0
	if isInMap(neighbor) == false or getVal(neighbor) ~= val then
		perimeter = perimeter + 1
	end
	if isInMap(neighbor) == true and getVal(neighbor) == val and seen[neighbor.i][neighbor.j] == false then
		perimeter = perimeter + Count(neighbor)
	end
	return perimeter
end

function Count(point)
	local perimeter = 0
	seen[point.i][point.j] = true
	seen_count = seen_count + 1
	local val = getVal(point)
	perimeter = perimeter + GetPerimiter(val, moveLeft(point))
	perimeter = perimeter + GetPerimiter(val, moveUp(point))
	perimeter = perimeter + GetPerimiter(val, moveRight(point))
	perimeter = perimeter + GetPerimiter(val, moveDown(point))
	return perimeter
end

local cost = 0

for i, row in pairs(map) do
	for j, _ in pairs(row) do
		local point = newPoint(i, j)
		if seen[i][j] == true then
			goto continue
		end
		print("calc " .. point.i .. " " .. point.j)
		local curr_seen = seen_count
		print('DEBUGPRINT[3]: day12_1.lua:89: curr_seen=' .. curr_seen)
		local perimeter =  Count(point)
		print('DEBUGPRINT[1]: day12_1.lua:90: perimeter=' .. perimeter)
		local area = seen_count - curr_seen
		print('DEBUGPRINT[2]: day12_1.lua:92: area=' .. area)
		cost = cost + (area * perimeter)
		::continue::
	end
end

print(cost)
