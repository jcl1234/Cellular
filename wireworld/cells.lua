math.randomseed(os.time())
local settings = require("settings")

local cellFunc = {}
---------------------------------------------
cells = {}




--Create grid of cells
function cellFunc.create(default)
	settings.maxX, settings.maxY = math.floor(settings.width/settings.cellSize)-1, math.floor(settings.height/settings.cellSize)-1
	--Create cell grid
	for x=0, settings.maxX do
		local cellColumn = {}
		for y=0, settings.maxY do
			local state = toNum(default)
			--Get random state
			if default == "random" then
				state = math.random(1, getLen(settings.states))
			end
			table.insert(cellColumn, state)
		end
		table.insert(cells, cellColumn)
	end
	return cells
end

--Draw All Cells
function cellFunc.draw()
	local size = settings.cellSize
	ui.highlighted = nil
	local highlights = 0
	for x, col in pairs(cells) do
		for y, cell in pairs(col) do
			local xPos, yPos = (x-1)*size, (y-1)*size
			--Draw cell
			local col1, col2 = settings.states[state(cell)], settings.backgroundColor
			if not (col1[1] == col2[1] and col1[2] == col2[2] and col1[3] == col2[3]) then
				love.graphics.setColor(col1)
				love.graphics.rectangle("fill", xPos, yPos, size, size)
			end
			--Get highlighted pos
			if settings.ui.highlightCells then
				if highlights == 0 and ui.worldMouseX >= xPos and ui.worldMouseX <= xPos + size and ui.worldMouseY >= yPos and ui.worldMouseY <= yPos + size then
					ui.highlighted = {x, y}
					highlights = highlights + 1
				end
			end
		end
	end
	--Draw highlighted rectangle
	if ui.highlighted then
		local x, y = ui.highlighted[1], ui.highlighted[2]
		love.graphics.setColor(settings.ui.highlightColor)
		love.graphics.setLineWidth(settings.ui.highlightWidth)
		love.graphics.rectangle(settings.ui.highlightType, (x-1)*size, (y-1)*size, size, size)
	end
end


local lastTick = 0
--Run a generation on every cell
function cellFunc.generation()
	local newStates = {}
	--Get cell states
	for x, col in pairs(cells) do
		local newCol = {}
		for y, cell in pairs(col) do
			local rule = settings.rules[state(cell)]
			local newState = toNum(rule(x, y)) or cell
			table.insert(newCol, newState)
		end
		table.insert(newStates, newCol)
	end
	--Apply new cell states
	for x, col in pairs(newStates) do
		for y, state in pairs(col) do
			if state ~= nil then
				cells[x][y] = state
			end
		end
	end
	settings.generation = settings.generation + 1
end

--Check if its time to run a generation
function cellFunc.update(dt)
	lastTick = lastTick + dt
	if lastTick >= settings.tickRate then
		cellFunc.generation()
		lastTick = 0
	end
end
---------------------------------------------

return cellFunc


