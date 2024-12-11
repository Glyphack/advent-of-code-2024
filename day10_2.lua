local utils = require("util")

local input = utils.split_string(utils.read_multiline_input(), "\n")

local map = {}
local trails = {}
local function newPoint(i, j)
	return { i = i, j = j }
end

local function getVal(point)
	return map[point.i][point.j]
end

local zeroPositions = {}

for i = 1, #input do
	local line = input[i]
	map[i] = {}
	for j = 1, #line do
		local char = line:sub(j, j)
		if char == "0" then
			table.insert(zeroPositions, newPoint(i, j))
		end
		map[i][j] = tonumber(char)
	end
end
utils.printMap(map)

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

local function MoveTo9(point, indent, seen)
	print(string.rep(" ", indent) .. "i: " .. point.i .. " j: " .. point.j)
	local val = getVal(point)
	if val == 9 then
		return 1
	end
	local up = moveUp(point)
	local rating = 0
	if isInMap(up) and val + 1 == getVal(up) then
		print(string.rep(" ", indent) .. "going up")
		rating = rating + MoveTo9(up, indent + 2, seen)
		print(string.rep(" ", indent) .. "score: " .. rating)
	end
	local down = moveDown(point)
	if isInMap(down) and val + 1 == getVal(down) then
		print(string.rep(" ", indent) .. "going down")
		rating = rating + MoveTo9(down, indent + 2, seen)
		print(string.rep(" ", indent) .. "score: " .. rating)
	end
	local left = moveLeft(point)
	if isInMap(left) and val + 1 == getVal(left) then
		print(string.rep(" ", indent) .. "going left")
		rating = rating + MoveTo9(left, indent + 2, seen)
		print(string.rep(" ", indent) .. "score: " .. rating)
	end
	local right = moveRight(point)
	if isInMap(right) and val + 1 == getVal(right) then
		print(string.rep(" ", indent) .. "going right")
		rating = rating + MoveTo9(right, indent + 2, seen)
		print(string.rep(" ", indent) .. "score: " .. rating)
	end
	return rating
end

for _, start in pairs(zeroPositions) do
	print("starting from")
	utils.printTable(start)
	local rating = MoveTo9(start, 0, {})
	if rating > 0 then
		table.insert(trails, { i = start.i, j = start.j, score = rating })
	end
end

utils.printTable(trails)
local sum = 0
for _, p in pairs(trails) do
	sum = sum + p.score
end

print(sum)
