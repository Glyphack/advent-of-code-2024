local utils = require("util")

local function checkmas(inputs, i1, i2, i3, i4, i5, i6)
	local c1 = inputs[i1]:sub(i2, i2)
	local c2 = inputs[i3]:sub(i4, i4)
	local c3 = inputs[i5]:sub(i6, i6)
	if c1 == "M" and c2 == "A" and c3 == "S" then
		return true
	end

	if c1 == "S" and c2 == "A" and c3 == "M" then
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
		if char == "M" or char == "S" then
			if i + 2 <= height then
				local ltr = checkmas(inputs, i, j, i + 1, j + 1, i + 2, j + 2)
				local rtl = checkmas(inputs, i, j + 2, i + 1, j + 1, i + 2, j)
				if ltr and rtl then
					count = count + 1
				end
			end
		end
	end
end

print(count)
