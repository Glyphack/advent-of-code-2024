local utils = require("util")

local input = utils.split_string(utils.read_multiline_input(), "\n")

print(input)

local reports = {}
for i, line in pairs(input) do
	local line_split = utils.split_string(line, " ")
	reports[i] = line_split
end

local safe = 0
for i, report in pairs(reports) do
	print("checking report")
	utils.printTable(report)
	local increasing = 0
	local decreasing = 0
	local prevLevel = 0
	for j, level in pairs(report) do
		level = tonumber(level)
		if j == 1 then
			prevLevel = level
			goto continue
		end

		if j == 2 then
			if level >= prevLevel then
				increasing = 1
			else
				decreasing = 1
			end
		end

		local diff = math.abs(level - prevLevel)
		if diff < 1 or diff > 3 then
			print("not safe because of difference")
			goto NotSafe
		end

		if increasing == 1 and level < prevLevel then
			print("report not safe because level", level ,"was lower than previous level" ,prevLevel)
			goto NotSafe
		end

		if decreasing == 1 and level > prevLevel then
			print("report not safe because level" , level, "was bigger than previous level" ,prevLevel)
			goto NotSafe
		end


		prevLevel = level
		::continue::

	end
	print("report is safe")
	safe = safe + 1
	::NotSafe::
end

print(safe)
