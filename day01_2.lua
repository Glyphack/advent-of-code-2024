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
	if list2[l2] ~= nil then
		list2[l2] = list2[l2] + 1
	else
		list2[l2] = 1
	end
end

local similarity = 0

for _, n in pairs(list1) do
	if list2[n] == nil then
		goto continue
	end
	local repeated = list2[n]
	print("number", n, "repeated", repeated)
	similarity = similarity + n * repeated
	::continue::
end

print(similarity)
