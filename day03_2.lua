local utils = require("util")

local function readMul(input, pos)
	pos = pos + 1
	if input:sub(pos, pos) ~= "u" then
		print("no u")
		return 0
	end
	pos = pos + 1
	if input:sub(pos, pos) ~= "l" then
		print("no l")
		return 0
	end
	pos = pos + 1
	if input:sub(pos, pos) ~= "(" then
		print("no paren")
		return 0
	end
	pos = pos + 1
	local char = input:sub(pos, pos)
	local firstNum = ""
	while char:match("%d") do
		firstNum = firstNum .. char
		pos = pos + 1
		char = input:sub(pos, pos)
	end
	if input:sub(pos, pos) ~= "," then
		print("no comma")
		return 0
	end

	local first = tonumber(firstNum)

	pos = pos + 1
	char = input:sub(pos, pos)
	local secondNum = ""
	while char:match("%d") do
		secondNum = secondNum .. char
		pos = pos + 1
		char = input:sub(pos, pos)
	end
	if input:sub(pos, pos) ~= ")" then
		print("no r paren found" .. input:sub(pos, pos))
		return 0
	end

	local second = tonumber(secondNum)

	print("mul(" .. firstNum .. ", " .. secondNum .. ")")

	return first * second
end

local function getDisable(input, pos)
	if input:sub(pos, pos + 4) == "don't" then
		return true
	end
	if input:sub(pos, pos + 1) == "do" then
		return false
	end
end

local inputs = utils.split_string(utils.read_multiline_input(), "\n")

utils.printTable(inputs)

local sum = 0
local disabled = false
for _, input in pairs(inputs) do
	for c = 1, #input do
		local char = input:sub(c, c)
		-- print(char)
		if char == "m" then
			print("found m")
			local mul = readMul(input, c)
			if disabled == false then
				sum = sum + mul
			end
		end
		if char == "d" then
			print("found d")
			disabled = getDisable(input, c)
		end
	end
end

print(sum)
