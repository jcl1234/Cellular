local settings = require("settings")
local ui = {}
ui.mouseX, ui.mouseY = love.mouse.getPosition()
ui.highlighted = {nil, nil}
------

function ui.update(dt)
	ui.mouseX, ui.mouseY = love.mouse.getPosition()
	ui.worldMouseX, ui.worldMouseY = (ui.mouseX/settings.zoom)-settings.offsetX, (ui.mouseY/settings.zoom)- settings.offsetY
end

function ui.draw()

	--Info Panel
	local infoX, infoY, infoWidth, infoHeight = settings.ui.x, settings.ui.y, settings.ui.width, settings.ui.height
	if (ui.mouseX >= infoX and ui.mouseY >= infoY and ui.mouseX <= infoWidth and ui.mouseY <= infoHeight) then
		infoX = settings.width - infoWidth
	end
	--Background
	love.graphics.setColor(settings.ui.color)
	love.graphics.rectangle("fill", infoX, infoY, infoWidth, infoHeight)
	love.graphics.setColor(settings.ui.borderColor)
	love.graphics.setLineWidth(settings.ui.borderWidth)
	love.graphics.rectangle("line", infoX, infoY,infoWidth, infoHeight)

	--INFO
	--Speed
	love.graphics.setColor(settings.ui.textColor)
	love.graphics.print("Tick Rate: "..settings.tickRate, 10+infoX, 5+infoY)
	--Generation
	love.graphics.print("Generation: "..settings.generation, infoX+10, infoY+infoHeight-30)
	--Edge Wrapping
	love.graphics.print("Edge Wrapping: "..(function() if settings.edgeWrap then return "on" else return "off" end end)(), infoX+infoWidth-130, infoY+infoHeight-30)
	--Paused
	if settings.pause then
		love.graphics.print("Paused", infoX+infoWidth-50, 10+infoY)
	end
	--Highlighted info
	if ui.highlighted then
		--Alive
		love.graphics.print("Surrounding Alive: "..count(ui.highlighted[1], ui.highlighted[2], "on"), 10+infoX, 20+infoY)
	end
end



return ui