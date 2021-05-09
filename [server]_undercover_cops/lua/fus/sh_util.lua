--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_undercover_cops/lua/fus/sh_util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function fus.findPlayer( str )

      str                = str:lower()
      local players      = player.GetAll()

      for i = 1, #players do

            local ply = players[ i ]
            if not ply then continue end

            if str == ply:SteamID():lower() then
                  return ply
            end

            if ply:Name():lower():find( str, 1, true ) == 1 then
                  return ply
            end

      end

      return false

end

function fus.isSteamID( str )
      return ( str:sub( 1, 8 ) == 'STEAM_0:' )
end

function fus.translate( key )
      return fus.config.translate[ key ] or ''
end
