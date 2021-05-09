--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/entities/ss_shelf_woodenrack/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include('shared.lua')

ENT.dummyAlterations = {
    [ "weapon_rpg" ] = function( ent )

    	ent:SetModelScale( 0.8, 0 )

    	return Vector( -13, -1, 2 ), Angle( 0, 0, 0 ), nil -- return ADDED POSITION, ADDED ANGLES, MODEL STRING
    end,
    [ "weapon_cuff_shackles" ] = function( ent )

    	ent:SetModelScale( 0.8, 0 )
    	--L.R--B.F--U.D
    	return Vector( -1, -6, 0 ), Angle( 0, 0, 0 ), nil -- return ADDED POSITION, ADDED ANGLES, MODEL STRING
    end,
    [ "weapon_cuff_tactical" ] = function( ent )

    	ent:SetModelScale( 0.8, 0 )
    	--L.R--B.F--U.D
    	return Vector( -1, -6, 0 ), Angle( 0, 0, 0 ), nil -- return ADDED POSITION, ADDED ANGLES, MODEL STRING
    end,
    [ "fire_extinguisher_limited" ] = function( ent )

    	ent:SetModelScale( 0.8, 0 )
    	--L.R--B.F--U.D
    	return Vector( -1, 2, 2 ), Angle( 90, 90, 0 ), nil -- return ADDED POSITION, ADDED ANGLES, MODEL STRING
    end,
    [ "heavy kevlar armor" ] = function( ent )

    	ent:SetModelScale( 0.6, 0 )
    	--L.R--B.F--U.D
    	return Vector( -1, 2, 4 ), Angle( 0, 0, 0 ), nil -- return ADDED POSITION, ADDED ANGLES, MODEL STRING
    end,
    [ "medium kevlar armor" ] = function( ent )

    	ent:SetModelScale( 0.6, 0 )
    	--L.R--B.F--U.D
    	return Vector( -1, 2, 4 ), Angle( 0, 0, 0 ), nil -- return ADDED POSITION, ADDED ANGLES, MODEL STRING
    end,
    [ "light kevlar armor" ] = function( ent )

    	ent:SetModelScale( 0.6, 0 )
    	--L.R--B.F--U.D
    	return Vector( -1, 2, 4 ), Angle( 0, 0, 0 ), nil -- return ADDED POSITION, ADDED ANGLES, MODEL STRING
    end
}
