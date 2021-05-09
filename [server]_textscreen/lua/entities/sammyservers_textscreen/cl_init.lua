--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_textscreen/lua/entities/sammyservers_textscreen/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

local FADE_DISTANCE = 650
local FADE_DISTANCE_LENGTH = 100--if i < 20 then
-- i = math.Clamp(i, 20, 100)
--end

for i = 20, 100 do
  --  if i <= 0 then
--    local i = math.Clamp(size, 1, 100)
--  end
  
	surface.CreateFont('textscreen_' .. tostring(i), {
		font = 'CoolVetica',
		size = i,
		weight = 400,
		antialias = false,
		outline = true,
		shadow = true
	})
end

--[[ ]]
function ENT:Initialize()

	self._lines = {}
	self._maxDistance = 0

	net.Start('textscreens_download')
		net.WriteEntity(self)
	net.SendToServer()

end

--[[ ]]
function ENT:setLines(lines)
	self._lines = lines
	self._maxDistance = 0

	local totalHeight = 0
	for index, line in ipairs(self._lines) do

		line.size = math.Clamp(line.size, 1, 100)
		line.font = 'textscreen_' .. line.size

		line.maxDistance = FADE_DISTANCE * math.Clamp(line.size * .01 + .1, 0, 1)
		self._maxDistance = math.max(self._maxDistance, line.maxDistance)

		surface.SetFont(line.font)
		local width, height = surface.GetTextSize(line.text)

		line.width = width
		line.height = height

		totalHeight = totalHeight + height

	end

	local  startHeight = -(totalHeight * .5)
	for index, line in ipairs(self._lines) do

		line.x = -(line.width * .5)
		line.y = startHeight

		startHeight = startHeight + line.height
	end

end

--[[ ]]
function ENT:DrawTranslucent()

	local pos = self:GetPos()
	local client = LocalPlayer()

	local distance = client:GetPos():Distance(pos)
	if self._maxDistance + FADE_DISTANCE_LENGTH <= distance then
		return
	end

	local angle = self:GetAngles()
	angle:RotateAroundAxis(angle:Up(), 90)

	-- Flip if standing behind the text screen
	if (pos - client:EyePos()):Dot(angle:Up()) > 0 then
		angle:RotateAroundAxis(angle:Right(), 180)
	end

	-- Draw the text (just a little bit up, which means just a little off the wall, so it doesn't glitch)
	cam.Start3D2D(pos, angle, .25)
		render.PushFilterMin(TEXFILTER.ANISOTROPIC)

		local lines = self._lines
		for i=1, #lines do
			local line = lines[i]

			local opacity = 1 - math.max(distance - line.maxDistance, 0) / FADE_DISTANCE_LENGTH
			if opacity <= 0.05 then
				continue
			end

			line.color.a = 255 * opacity
			
			surface.SetFont(line.font)
			surface.SetTextColor(line.color)
			surface.SetTextPos(line.x, line.y)
			surface.DrawText(line.text)

		end

		render.PopFilterMin()
	cam.End3D2D()

end

net.Receive('textscreens_update', function(len)
	local ent = net.ReadEntity()

	if not IsValid(ent) then
		return
	end

	ent:setLines(net.ReadTable())

end)
