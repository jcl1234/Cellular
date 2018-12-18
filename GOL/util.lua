local settings = require("settings")
--Utility functions--
--Toggle bool
function toggleSetting(bool)
	if settings[bool] == true then settings[bool] = false
	else settings[bool] = true end
	return settings[bool]
end


--Get length of table
function getLen(t)
	len = 0
	for k, v in pairs(t) do len = len + 1 end
	return len
end


--Get name of state from number
function state(num)
	if type(num) == "string" then return state end
	ind=1
	for state, v in pairs(settings.states) do
		if num == ind then return state end
		ind = ind + 1
	end
end

--Get number from state
function toNum(state)
	if type(state) ~= "string" then return state end
	ind = 1
	for stateName, col in pairs(settings.states) do
		if stateName == state then return ind end
		ind = ind + 1
	end
end

--Count number of states around cell
function count(x, y, ...)
	local states = {...}
	local counts = 0

	--Set up counts as table if multiple states
	if getLen(states) > 1 then
		counts = {}
		for k, state in pairs(states) do
			table.insert(counts, 0)
		end
	end

	for surroundX=-1, 1 do
		for surroundY=-1, 1 do
			if not (surroundX==0 and surroundY==0) then
				local xPos, yPos = x + surroundX, y + surroundY
				local maxX, maxY = settings.maxX+1, settings.maxY+1
				--Edge scrolling
				if settings.edgeWrap then
					--Horizontal
					if xPos < 1 or xPos > maxX then
						if xPos < 1 then xPos = maxX end
						if xPos > maxX then xPos = 1 end
					end
					--Vertical
					if yPos < 1 or yPos > maxY then
						if yPos < 1 then yPos = maxY end
						if yPos > maxY then yPos = 1 end
					end
				end
				--See if state is in states
				for k, state in pairs(states) do
					local col = cells[xPos]
					if col and col[yPos] == toNum(state) then
						if type(counts) == "table" then
							counts[k] = counts[k] + 1
						else
							counts = counts + 1
						end
					end
				end
			end
		end
	end

	return counts
end

