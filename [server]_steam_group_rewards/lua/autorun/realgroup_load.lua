--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_steam_group_rewards/lua/autorun/realgroup_load.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function includecl(s)
     if SERVER then
          AddCSLuaFile(s)
     else
          include(s)
     end
end
AddCSLuaFile()
local function includesh(s)
     if SERVER then
          AddCSLuaFile(s)
     end
     include(s)
end

includesh("realgroup_config.lua")

if SERVER then
     include("realgroup/sv_realgroup.lua")
end

includecl("realgroup/import/matui.lua")
includecl("realgroup/import/extext.lua")

includecl("realgroup/cl_realgroup.lua")
