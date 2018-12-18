local settings = require("settings")
local cell = require("cells")
---------------------

--Pause game
local function pause()
	if settings.pause then settings.pause = false else settings.pause = true end
end

--Place & delete cells
local function place()
	if not ui.highlighted then return end
	local x, y = ui.highlighted[1], ui.highlighted[2]
	cells[x][y] = toNum(settings.clickPlace)
end
local function remove()
	if not ui.highlighted then return end
	local x, y = ui.highlighted[1], ui.highlighted[2]
	cells[x][y] = toNum(settings.rightClickPlace)
end

--Reset map
local function reset()
	if not settings.reset then return end
	for x, col in pairs(cells) do
		for y, cell in pairs(col) do
			cells[x][y] = toNum(settings.resetState)
		end
	end
	settings.tickRate = settings.startTick
	settings.generation = 0
	settings.pause = true
end


--Slow and Increase speed
local function slow()
	local newTick = settings.tickRate + settings.tickIncreaseRate*(settings.tickRate*.2)
	settings.tickRate = newTick
end
local function speed()
	local newTick = settings.tickRate - settings.tickIncreaseRate*(settings.tickRate*.2)
	if newTick > 0 then
		settings.tickRate = newTick
	end
end

--Zoom in and out
local function zin()
	settings.zoom = settings.zoom + settings.zoomRate
end
local function zout()
	settings.zoom = settings.zoom - settings.zoomRate
end

--Screen movement
local function right() settings.offsetX = settings.offsetX - settings.offsetRate/settings.zoom end
local function left() settings.offsetX = settings.offsetX + settings.offsetRate/settings.zoom end
local function up() settings.offsetY = settings.offsetY + settings.offsetRate/settings.zoom end
local function down() settings.offsetY = settings.offsetY - settings.offsetRate/settings.zoom end

local function resetScreen() settings.offsetX, settings.offsetY, settings.zoom = 0, 0, 1 end

local function edge() toggleSetting("edgeWrap") end

local controls = {
	space = pause,
	r = reset,
	t = resetScreen,
	n = cell.generation,
	m = edge,

	i = zout,
	o = zin,

	--Movement
	right = right,
	left = left,
	up = up,
	down = down,

	mouse = {
		place,
		remove,
	},

	wheel = {
		zin,
		zout,
	},
}
controls[","] = slow
controls["."] = speed

return controls