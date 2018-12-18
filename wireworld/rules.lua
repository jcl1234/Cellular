local function conRules(x, y)
	local heads = count(x, y, "head")
	if heads == 1 or heads == 2 then
		return "head"
	end
end

local function headRule(x, y)
	return "tail"
end

local function tailRule(x, y)
	return "connector"
end

local function offRule(x, y)
	return "off"
end

--Rules for each state, should return new state
local rules = {
	off = offRule,
	connector = conRules,
	head = headRule,
	tail = tailRule,
}




return rules