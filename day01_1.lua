local function read_multiline_input()
	local lines = {}
	for line in io.lines() do
		table.insert(lines, line)
	end
	return table.concat(lines, "\n")
end

local function split_string(input_str, delimiter)
	local result = {}
	for match in (input_str .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

local function print_table(t)
	for k, v in pairs(t) do
		print(k, v)
	end
end

local function trim(s)
	return s:match("^%s*(.-)%s*$")
end

local lines = split_string(read_multiline_input(), "\n")

local list1 = {}
local list2 = {}

for i, line in pairs(lines) do
	local l1, l2 = table.unpack(split_string(line, "   "))
	list1[i] = l1
	list2[i] = l2
end

table.sort(list1)
table.sort(list2)

local diffs = 0
local i = 1
while i <= #list1 do
	diffs = diffs + math.abs(list1[i] - list2[i])
	i = i + 1
end

print(diffs)
