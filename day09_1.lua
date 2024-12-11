local utils = require("util")

local input = io.read()

local freeSpace = "."
local disk = {}

local readFile = true
local fileID = 0
for i = 1, #input do
	local char = input:sub(i, i)
	if readFile then
		for _ = 0, tonumber(char) - 1 do
			table.insert(disk, fileID)
		end
		readFile = false
		fileID = fileID + 1
	else
		for _ = 0, tonumber(char) - 1 do
			table.insert(disk, freeSpace)
		end
		readFile = true
	end
end

utils.printTableLine(disk)
print("len " .. #disk)

print("now")

local endCursor = #disk
local freeCursor = 1

while endCursor >= freeCursor do
	print("iter")
	while disk[endCursor] == freeSpace do
		endCursor = endCursor - 1
	end
	while disk[freeCursor] ~= freeSpace do
		freeCursor = freeCursor + 1
	end
	if endCursor < freeCursor then
		break
	end
	disk[freeCursor] = disk[endCursor]
	disk[endCursor] = "."
	print("f: " .. freeCursor .. " e: " .. endCursor)
end

print("final")
utils.printTableLine(disk)

local checksum = 0
for i, val in pairs(disk) do
	if val == freeSpace then
		break
	end
	checksum = checksum + ((i - 1) * val)
end
print(checksum)
