require("util")
ui = require("ui")
--
local settings = require("settings")
local cell = require("cells")
local controls = require("controls")

--Love functions--------------------------------------
function love.keypressed(key)
	if controls[key] then controls[key]() end
end

--Scrolling
function love.wheelmoved(x, y)
    if y > 0 then
        if controls.wheel[1] then controls.wheel[1]() end
    elseif y < 0 then
        if controls.wheel[2] then controls.wheel[2]() end
    end
end


function love.load()
	love.window.setTitle(settings.title)
	love.window.setMode(settings.width, settings.height)
	love.graphics.setBackgroundColor(settings.backgroundColor)

	cell.create("off")
end

function love.update(dt)
	--Place cell
	if love.mouse.isDown(1) then
		controls.mouse[1]()
	end
	--Remove cell
	if love.mouse.isDown(2) then
		controls.mouse[2]()
	end

	if not settings.pause then
		cell.update(dt)
	end
	ui.update(dt)
end

function love.draw()

	--Positional Graphics
	love.graphics.push()
	love.graphics.scale(settings.zoom, settings.zoom)
	love.graphics.translate(settings.offsetX, settings.offsetY) 
	--Draw border of grid
	if settings.drawBorder then
		local width = settings.borderWidth
		local offset = width * 2
		love.graphics.setLineWidth(settings.borderWidth)
		love.graphics.setColor(settings.borderColor)
		local x, y = 0-width, 0-width
		love.graphics.rectangle("line", x, y, settings.width+offset, settings.height+offset)
	end
	cell.draw()
	love.graphics.pop()


	--Ui--
	ui.draw()
end