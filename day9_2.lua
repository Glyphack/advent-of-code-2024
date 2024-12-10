local utils = require("util")
local input = io.read()

local freeSpace = "."
local disk = {}
local fileIDLen = {}
local fileID = 0
local cursor = 1
local readFile = true

for i = 1, #input do
	local num = tonumber(input:sub(i, i))
	if readFile then
		table.insert(fileIDLen, { id = fileID, len = num, start = cursor })
		for _ = 1, num do
			table.insert(disk, fileID)
			cursor = cursor + 1
		end
		readFile = false
		fileID = fileID + 1
	else
		for _ = 1, num do
			table.insert(disk, freeSpace)
			cursor = cursor + 1
		end
		readFile = true
	end
end

table.sort(fileIDLen, function(a, b)
	return a.id > b.id
end)

local function findFreeSpace(len)
	local freeStart = nil
	local freeEnd = nil
	local i = 1
	while i ~= #disk do
		if disk[i] == freeSpace then
			freeStart = i
			freeEnd = freeStart
			while disk[freeEnd] == freeSpace do
				freeEnd = freeEnd + 1
			end
			if len <= freeEnd - freeStart then
				return freeStart, freeEnd
			end
		end
		i = i + 1
	end
	return nil, nil
end

for _, fileToCopy in pairs(fileIDLen) do
	-- print("moving")
	-- utils.printTable(fileToCopy)
	local len = fileToCopy.len
	local freeStart, freeEnd = findFreeSpace(len)
	if freeStart == nil then
		print("did not find a free space with len " .. len)
		goto continue
	end
	if freeStart > fileToCopy.start then
		print("file already on left most")
		goto continue
	end
	-- print("found spot starting at " .. freeStart .. " to " .. freeEnd)
	for i = freeStart, freeStart + len - 1 do
		disk[i] = fileToCopy.id
	end
	for i = fileToCopy.start, fileToCopy.start + len - 1 do
		disk[i] = freeSpace
	end
	-- utils.printTableLine(disk)
	::continue::
end

-- utils.printTableLine(disk)

local checksum = 0
for i, val in ipairs(disk) do
	if val ~= freeSpace then
		checksum = checksum + ((i - 1) * val)
	end
end
print(checksum)
