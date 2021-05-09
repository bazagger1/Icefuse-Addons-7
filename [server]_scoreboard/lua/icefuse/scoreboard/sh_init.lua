--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_scoreboard/lua/icefuse/scoreboard/sh_init.lua
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

local Addon = IcefuseScoreboard or {

    version = '1.0.2',
    versionNr = 102,

    name = 'Icefuse Scoreboard',
    alias = 'IcefuseScoreboard',
    identifier = 'icefuse.scoreboard',

    config = {}

}
IcefuseScoreboard = Addon

--------------------------------------------------
-- Utilities

--[[
- Includes a file.
- @arg string file
- @arg string type
]]
function Addon.include(file, type)
    if type == 'server' or type == 'shared' then
        if SERVER then
            include(file)
        end
    end
    if type == 'client' or type == 'shared' then
        if SERVER then
            AddCSLuaFile(file)
        else
            include(file)
        end
    end
end

--------------------------------------------------------------------------------

-- Include files
Addon.include('src/lib/sh_class.lua', 'shared')
Addon.include('src/lib/cl_component.lua', 'client')

Addon.include('config/sh_config.lua', 'shared')
Addon.include('config/cl_config.lua', 'client')

Addon.include('src/cl_misc.lua', 'client')
Addon.include('src/sv_misc.lua', 'server')

Addon.include('src/cl_fonts.lua', 'client')
Addon.include('src/cl_util.lua', 'client')
Addon.include('src/cl_view.lua', 'client')

Addon.include('src/view/cl_scoreboard.lua', 'client')
Addon.include('src/view/cl_player_list.lua', 'client')
Addon.include('src/view/cl_player_row.lua', 'client')

--------------------------------------------------------------------------------

if SERVER and Addon.config.downloadTestResources then
    -- Only on localhost

    -- resource.AddFile('materials/icefuse/scoreboard/icons/group_user.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/group_admin.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/group_manager.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/group_developer.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/group_ceo.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/group_vip.png')

    -- resource.AddFile('materials/icefuse/scoreboard/icons/voice_on.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/voice_off.png')

    -- resource.AddFile('materials/icefuse/scoreboard/icons/pin.png')

    -- resource.AddFile('materials/icefuse/scoreboard/icons/country/_unknown.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/country/US.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/country/NL.png')

    -- resource.AddFile('materials/icefuse/scoreboard/icons/os/windows.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/os/linux.png')
    -- resource.AddFile('materials/icefuse/scoreboard/icons/os/osx.png')

end
