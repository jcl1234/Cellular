local rules = require("rules")

--Possible cell states and their colors
local states = {
	off = {0,0,0},
	on = {1,1,1},
}

--Cellular Automata settings
local settings = {
	--Screen
	title = "Cellular Automata",
	backgroundColor = {0,0,0},
	width = 800,
	height = 600,
	--Border
	drawBorder = true,
	borderColor = {1,0,0},
	borderWidth = 5,

	maxX = nil,
	maxY = nil,

	--Cells
	cellSize = 8,
	states = states,
	rules = rules,

	--Game
	edgeWrap = true,
	tickIncreaseRate = .3,
	startTick = .1,
	pause = true,
	generation = 0,

	--Screen Offsets
	zoom = 1,
	zoomRate = .2,
	offsetX = 0,
	offsetY = 0,
	offsetRate = 20,


	--Placing
	placing = true,
	clickPlace = "on",
	rightClickPlace = "off",

	--Reset
	reset = true,	
	resetState = "off",

	--Ui
	ui = {
		--Info
		x = 0,
		y = 0,
		width = 300,
		height = 100,
		color = {.2,.2,.2,.6},
		borderColor = {1,0,0},
		borderWidth = 1,
		textColor = {1,1,1},

		--Highlighting
		highlightCells = true,
		highlightType = "line",
		highlightWidth = 2,
		highlightColor = {1,0,0},
	},
}
settings.tickRate = settings.startTick


return settings