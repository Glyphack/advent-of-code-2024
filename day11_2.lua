local utils = require("util")

local input = io.read()
local stones = utils.split_string(input, " ")

local last_blink = 75

utils.printTableLine(stones)

local function removeZeros(first)
	while string.sub(first, 1, 1) == "0" and #first > 1 do
		first = string.sub(first, 2, #first)
	end
	return first
end

local function cacheKey(stone, blink)
	return "s=" .. stone .. "b" .. blink
end

local cache = {}

local function count(stone, blink)
	if blink == last_blink then
		return 1
	end
	if cache[cacheKey(stone, blink)] ~= nil then
		return cache[cacheKey(stone, blink)]
	end

	if stone == "0" then
		cache[cacheKey(stone, blink)] = count("1", blink + 1)
		return cache[cacheKey(stone, blink)]
	elseif #stone % 2 == 0 then
		local first = string.sub(stone, 1, #stone / 2)
		first = removeZeros(first)
		local second = string.sub(stone, #stone / 2 + 1, #stone + 1)
		second = removeZeros(second)
		cache[cacheKey(stone, blink)] = count(first, blink + 1) + count(second, blink + 1)
		return cache[cacheKey(stone, blink)]
	end
	cache[cacheKey(stone, blink)] = count(tostring(tonumber(stone) * 2024), blink + 1)
	return cache[cacheKey(stone, blink)]
end

local sum = 0
for i = 1, #stones do
	local stone = stones[i]
	sum = sum + count(stone, 0)
end
print(string.format("%.0f", sum))
