--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_scoreboard/lua/icefuse/scoreboard/src/cl_util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--[[ -----------------------------------------------------------
	This script was made by ikefi
		http://steamcommunity.com/id/ikefi/
------------------------------------------------------------- ]]

local Addon = IcefuseScoreboard

----------------------------------------------------------------

local render_SetScissorRect = render.SetScissorRect
local render_SetMaterial = render.SetMaterial
local render_DrawScreenQuad = render.DrawScreenQuad

----------------------------------------------------------------

local BLUR_AMOUNT = 6
local BLUR_HEAVYNESS = 3

local MATERIAL_BLUR = Material('pp/blurscreen')
local MATERIAL_PANEL_BLUR = Material('pp/blurscreen')

--[[
- Draw a blured rectangle on the screen.
- @arg number x
- @arg number y
- @arg number w
- @arg number h
]]
function Addon.drawBluredRect(x, y, w, h)

	render.SetScissorRect(x, y, x + w, y + h, true)

		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(MATERIAL_BLUR)

		for i=1, BLUR_HEAVYNESS do
			MATERIAL_BLUR:SetFloat('$blur', (i / 3) * BLUR_AMOUNT)
			MATERIAL_BLUR:Recompute()

			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

		end

	render.SetScissorRect(0, 0, 0, 0, false)

end
local drawBluredRect = Addon.drawBluredRect

--[[
- Draws a blured rectangle over the whole panel.
-
- @arg panel panel
]]
function Addon.drawBluredPanel(panel)
    local x, y = panel:LocalToScreen(0, 0)
    local w, h = ScrW(), ScrH()

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(MATERIAL_PANEL_BLUR)

	for i=1, BLUR_HEAVYNESS do
		MATERIAL_PANEL_BLUR:SetFloat('$blur', (i / 3) * BLUR_AMOUNT)
		MATERIAL_PANEL_BLUR:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(-x, -y, w, h)

	end

end

----------------------------------------------------------------
-- Web material

Addon._webMaterialCache = Addon._webMaterialCache or {}

--[[
-
]]
function Addon.registerWebMaterial(name, options)
	assert(name)
	local url = assert(options.url)
	local extension = options.extension or 'dat'
	local onLoaded = options.onLoaded or function() end

	local path = 'icefuse/scoreboard/cache/' .. tostring(Addon.versionNr) .. '/'
	local fileName = util.Base64Encode(url):sub(1, math.Clamp(#url, 1, 128)) .. '.' .. extension
	local filePath = 'icefuse/scoreboard/cache/' .. tostring(Addon.versionNr) .. '/' .. fileName

	if file.Exists(filePath, 'DATA') then
		Addon._webMaterialCache[name] = Material('../data/' .. filePath, 'smooth')
		return onLoaded(Addon.getWebMaterial(name))
	end

	http.Fetch(url, function(body)

		file.CreateDir(path)
		file.Write(filePath, body)

		Addon._webMaterialCache[name] = Material('../data/' .. filePath .. 'smooth')
		onLoaded(Addon.getWebMaterial(name))

	end)

end

--[[
-
]]
function Addon.getWebMaterial(name)
	return Addon._webMaterialCache[name]
end
