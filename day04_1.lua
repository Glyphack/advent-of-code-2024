local utils = require("util")

local function checkXmas(inputs, i1, i2, i3, i4, i5, i6, i7, i8)
	local c1 = inputs[i1]:sub(i2, i2)
	local c2 = inputs[i3]:sub(i4, i4)
	local c3 = inputs[i5]:sub(i6, i6)
	local c4 = inputs[i7]:sub(i8, i8)
	-- print(c1, c2, c3, c4)
	if c1 == "X" and c2 == "M" and c3 == "A" and c4 == "S" then
		return true
	end
	return false
end

local inputs = utils.split_string(utils.read_multiline_input(), "\n")

utils.printTable(inputs)

local height = #inputs
local width = #inputs[1]

local count = 0
for i, input in pairs(inputs) do
	for j = 1, #input do
		local char = input:sub(j, j)
		if char == "X" then
			-- left to right
			if checkXmas(inputs, i, j, i, j + 1, i, j + 2, i, j + 3) then
				count = count + 1
			end
			-- right to left
			if checkXmas(inputs, i, j, i, j - 1, i, j - 2, i, j - 3) then
				count = count + 1
			end
			-- up to down
			if i + 3 <= height and checkXmas(inputs, i, j, i + 1, j, i + 2, j, i + 3, j) then
				count = count + 1
			end
			-- down to up
			if i - 3 > 0 and checkXmas(inputs, i, j, i - 1, j, i - 2, j, i - 3, j) then
				count = count + 1
			end
			-- up left to down right
			if i + 3 <= height and checkXmas(inputs, i, j, i + 1, j + 1, i + 2, j + 2, i + 3, j + 3) then
				count = count + 1
			end
			-- up right to down left
			if i + 3 <= height and checkXmas(inputs, i, j, i + 1, j - 1, i + 2, j - 2, i + 3, j - 3) then
				count = count + 1
			end
			-- down left to up right
			if i - 3 > 0 and checkXmas(inputs, i, j, i - 1, j + 1, i - 2, j + 2, i - 3, j + 3) then
				count = count + 1
			end
			-- down right to up left
			if i - 3 > 0 and checkXmas(inputs, i, j, i - 1, j - 1, i - 2, j - 2, i - 3, j - 3) then
				count = count + 1
			end
		end
	end
end

print(count)
