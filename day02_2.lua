local utils = require("util")

local input = utils.split_string(utils.read_multiline_input(), "\n")

local reports = {}
for i, line in pairs(input) do
	local line_split = utils.split_string(line, " ")
	reports[i] = line_split
end

print(#reports)

local function generateAlternativeReports(report)
	local altReports = {}
	for i, _ in pairs(report) do
		local newReport = utils.deepcopy(report)
		table.remove(newReport, i)
		altReports[i] = newReport
	end
	return altReports
end

local function checkReport(report)
	local increasing = 0
	local decreasing = 0
	local prevLevel = 0
	local diff = 0
	for j, level in pairs(report) do
		level = tonumber(level)
		if j == 1 then
			goto continue
		end

		if j == 2 then
			if level >= prevLevel then
				increasing = 1
			else
				decreasing = 1
			end
		end

		diff = math.abs(level - prevLevel)
		if diff < 1 or diff > 3 then
			print("not safe because of difference")
			return false
		end

		if increasing == 1 and level < prevLevel then
			print("report not safe because level", level, "was lower than previous level", prevLevel)
			return false
		end

		if decreasing == 1 and level > prevLevel then
			print("report not safe because level", level, "was bigger than previous level", prevLevel)
			return false
		end

		::continue::
		prevLevel = level
	end
	return true
end

local safe = 0
for i, report in pairs(reports) do
	print("checking report")
	utils.printTable(report)
	if checkReport(report) == true then
		safe = safe + 1
		print("report is safe")
	else
		local altReports = generateAlternativeReports(report)
		for _, altReport in pairs(altReports) do
			if checkReport(altReport) == true then
				safe = safe + 1
				break
			end
		end
	end
end

print(safe)
