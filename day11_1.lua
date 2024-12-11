local utils = require("util")

local input = io.read()

local stones = utils.split_string(input, " ")

-- for i, stone in pairs(stones) do
-- 	stones[i] = tonumber(stone)
-- end
utils.printTableLine(stones)

local function removeZeros(first)
	while string.sub(first, 1, 1) == "0" and #first > 1 do
		first = string.sub(first, 2, #first)
	end
	return first
end

for blink = 1, 75 do
	local new_stones = {}
	for i, stone in pairs(stones) do
		if stone == "0" then
			table.insert(new_stones, "1")
		elseif #stone % 2 == 0 then
			local first = string.sub(stone, 1, #stone / 2)
			first = removeZeros(first)
			local second = string.sub(stone, #stone / 2 + 1, #stone + 1)
			second = removeZeros(second)
			table.insert(new_stones, first)
			table.insert(new_stones, second)
		else
			table.insert(new_stones, tostring(tonumber(stone) * 2024))
		end
	end
	stones = utils.deepcopy(new_stones)
	print("after blink " .. blink)
	blink = blink + 1
end

print(#stones)
