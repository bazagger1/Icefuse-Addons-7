--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_scoreboard/lua/icefuse/scoreboard/config/cl_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local config = IcefuseScoreboard.config

--------------------------------------------------
-- Usergroup icon

local ICON_GROUP_USER = Material('icefuse/scoreboard/icons/group_user.png', 'noclamp smooth')
local ICON_GROUP_ADMIN = Material('icefuse/scoreboard/icons/group_admin.png', 'noclamp smooth')
local ICON_GROUP_MANAGER = Material('icefuse/scoreboard/icons/group_manager.png', 'noclamp smooth')
local ICON_GROUP_VIP = Material('icefuse/scoreboard/icons/group_vip.png', 'noclamp smooth')
local ICON_GROUP_DEVELOPER = Material('icefuse/scoreboard/icons/group_developer.png', 'noclamp smooth')
local ICON_GROUP_CEO = Material('icefuse/scoreboard/icons/group_ceo.png', 'noclamp smooth')

local userGroupIcons = {
    ['c_e_o'] = ICON_GROUP_CEO,
    ['developer'] = ICON_GROUP_DEVELOPER,
    ['vip'] = ICON_GROUP_VIP,
    ['manager'] = ICON_GROUP_MANAGER
}

--[[
- Returns a usergroup icon for the player.
-
- @param player player
-
- @return material
]]
config.getUserGroupIconMaterial = function(player)
    local userGroup = player:GetUserGroup()

    if player:IsAdmin() then
        return ICON_GROUP_ADMIN
    end

    if userGroupIcons[userGroup] then
        return userGroupIcons[userGroup]
    end

    return ICON_GROUP_USER
end
