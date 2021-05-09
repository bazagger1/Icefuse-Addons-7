--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_radio_script/lua/fradio/sh_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]



FRadio = {

    version = '1.1.0',

    identifier = 'fradio',
    name = 'Frequency Radio',
    nameShort = 'FRadio',

    config = {}

}

-- Include types
local INCLUDE_SERVER = 1
local INCLUDE_CLIENT = 2
local INCLUDE_SHARED = 3

-- Utilities
do

	--[[
	- Includes a file.
	- @arg string file
	- @arg numbet type INCLUDE_SERVER|INCLUDE_CLIENT|INCLUDE_SHARED
	]]
	function FRadio.include(file, type)
		if type == INCLUDE_SERVER or type == INCLUDE_SHARED then
			if SERVER then
				include(file)
			end
		end
		if type == INCLUDE_CLIENT or type == INCLUDE_SHARED then
			if SERVER then
				AddCSLuaFile(file)
			else
				include(file)
			end
		end
	end

end

-- Include files
do

    FRadio.include('config/server.lua', INCLUDE_SERVER)
    FRadio.include('include/cl_keybind.lua', INCLUDE_CLIENT)
    FRadio.include('include/sh_radio.lua', INCLUDE_SHARED)
    FRadio.include('include/sv_radio.lua', INCLUDE_SERVER)
    FRadio.include('include/cl_radio.lua', INCLUDE_CLIENT)
    FRadio.include('include/cl_menu.lua', INCLUDE_CLIENT)

end
