local utils = require("util")

function table_contains(tbl, x)
	for _, v in pairs(tbl) do
		if v == x then
			return true
		end
	end
	return false
end

local lines = utils.split_string(utils.read_multiline_input(), "\n")

local readingRules = true
local rules = {}
local updates = {}
for _, line in pairs(lines) do
	if line:find("|") then
		local before, after = table.unpack(utils.split_string(line, "|"))
		table.insert(rules, { before = before, after = after })
	else
		table.insert(updates, utils.split_string(line, ","))
	end
end

utils.printTable(rules)
utils.printTable(updates)

local index = {}
for i, rule in pairs(rules) do
	if index[rule.after] == nil then
		index[rule.after] = {}
	end
	index[rule.after][rule.before] = 1
end

print("index")
utils.printTable(index)
print("solving")

local correct = {}

for i, update in pairs(updates) do
	print("checking")
	utils.printTable(update)
	local valid = true
	for j = 1, #update do
		local page = update[j]
		print("page:" .. page)
		local onlyBefore = index[page]
		if onlyBefore == nil then
			onlyBefore = {}
		end
		for k = j, #update do
			local nextPage = update[k]
			if onlyBefore[nextPage] == 1 then
				print(nextPage .. "not allowed to be after " .. page)
				valid = false
			end
		end
	end
	if valid == true then
		table.insert(correct, update)
		print("was valid")
	end
end

utils.printTable(correct)

local middles = 0

for i = 1, #correct do
	local set = correct[i]
	local mid = set[math.ceil(tonumber(#set) / 2)]
	print("mid:" .. mid)
	middles = middles + mid
end

print(middles)
