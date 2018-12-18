--Off cell rules
local function offRules(x, y)
	if count(x, y, "on") == 3 then
		return toNum("on")
	end
end

--On cell rules
local function onRules(x, y)
	local living = count(x, y, "on")
	if living < 2 or living > 3 then
		return toNum("off")
	end
end

--Rules for each state, should return new state
local rules = {
	off = offRules,
	on = onRules
}




return rules