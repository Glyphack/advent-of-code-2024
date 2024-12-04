local module = {}

function module.read_multiline_input()
	local lines = {}
	for line in io.lines() do
		table.insert(lines, line)
	end
	return table.concat(lines, "\n")
end

function module.split_string(input_str, delimiter)
	local result = {}
	for match in (input_str .. delimiter):gmatch("(.-)" .. delimiter) do
		if match ~= "" then
			table.insert(result, match)
		end
	end
	return result
end

function module.printTable(tbl, indent)
	indent = indent or 0
	local indentStr = string.rep("  ", indent)
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			print(indentStr .. tostring(k) .. ":")
			module.printTable(v, indent + 1)
		else
			print(indentStr .. tostring(k) .. ": " .. tostring(v))
		end
	end
end

function module.trim(s)
	return s:match("^%s*(.-)%s*$")
end

function module.deepcopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			copy[k] = module.deepcopy(v)
		else
			copy[k] = v
		end
	end
	return copy
end

return module
