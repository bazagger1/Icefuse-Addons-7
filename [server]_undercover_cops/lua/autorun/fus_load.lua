--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_undercover_cops/lua/autorun/fus_load.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

fus                           = fus or {}
fus.config                    = {}
fus.jobData                   = {}
fus.allowedPlayers            = {}
fus.commands                  = {}
fus.load                      = {}
fus.load[ 'sv' ]              = SERVER and include or function() end
fus.load[ 'sh' ]              = SERVER and function( path ) include( path ) AddCSLuaFile( path ) end or include
fus.load[ 'cl' ]              = CLIENT and include or AddCSLuaFile

function fus.notifyServer( str )
      MsgC( Color( 25, 255, 25 ), 'Icefuse Admin: ', color_white, str .. '\n' )
end

fus.notifyServer( 'Initializing Icefuse Police System..' )
--fus.notifyServer( 'Starting loading proccess!' )

local data, _                    = file.Find( 'fus/*.lua', 'LUA' )

for _, str in ipairs( data ) do

      if fus.load[ str:sub( 1, 2 ) ] then

            fus.load[ str:sub( 1, 2 ) ]( 'fus/' .. str )
            fus.notifyServer( 'Loaded file: ' .. str )

      else

            fus.notifyServer( 'Invalid file format: ' .. str )

      end

end

fus.notifyServer( 'Fully loaded!' )
