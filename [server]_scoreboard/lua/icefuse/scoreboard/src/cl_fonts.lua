--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_scoreboard/lua/icefuse/scoreboard/src/cl_fonts.lua
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

local identifier = Addon.identifier

----------------------------------------------------------------

--[[
- @param string name
- @param table|nil options
-
- @return string - Returns the full (prefixed) name of the font
]]
function Addon.font(name, options)
    name = identifier .. '.' .. name

    if options ~= nil then
        surface.CreateFont(name, options)
    end

    return name
end
local font = Addon.font

----------------------------------------------------------------

font('small', {
    font = 'Roboto',
    size = 14,
    weight = 300,
    antialias = true
})

font('small.underline', {
    font = 'Roboto',
    size = 14,
    weight = 300,
    antialias = true
	-- underline = true
})

font('footer', {
    font = 'Roboto',
    size = 14,
    weight = 300,
    antialias = true
})
