--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_undercover_cops/lua/fus/sh_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--
-- To configure wether or not an admin rank is allowed
-- Just add the following:
-- fus.config.adminRanks[ 'InsertRank' ] = true
--

fus.config.adminRanks                           = {} -- Make sure it's after this line
fus.config.adminRanks[ 'superadmin' ]           = true
fus.config.adminRanks[ 'root' ]                 = true
fus.config.adminRanks[ 'c_e_o' ]           = true
fus.config.adminRanks[ 'developer' ]           = true

--
-- To configure which teams are allowed to use the System
-- Just add the following:
-- fus.config.allowedTeams[ TEAM_NAME ] = true
--

fus.config.allowedTeams                         = {} -- Don't touch this :D

timer.Simple( 0, function() -- Don't worry about this, this is just to avoid errors

fus.config.allowedTeams[ TEAM_FIB ] = true
fus.config.allowedTeams[ TEAM_POLICE_OFFICER ] = true
fus.config.allowedTeams[ TEAM_POLICE_CHIEF ] = true
fus.config.allowedTeams[ TEAM_POLICE ]          = true
fus.config.allowedTeams[ TEAM_CHIEF ]           = true

end )

--
-- Undercover information
-- These are used in the actual undercover part of the script :D
--

fus.config.undercover                           = {}
fus.config.undercover[ 'undercoverTime' ]       = 600 -- Time in seconds the undercover time lasts (Set to 0 to be infinite!), 180 = 03 minutes, 300 = 05 minutes, 600 = 10 minutes
fus.config.undercover[ 'undercoverCooldown' ]   = 300 -- Cooldown (in seconds).
fus.config.undercover[ 'endOnDeath' ]           = true -- Should the undercover mode end when a player dies
fus.config.undercover[ 'allowTeamChange' ]      = true -- Should the player be allowed to change teams while undercover?

--
-- NPC Configuration
--

fus.config.npc                                  = {} -- Don't touch this :D
fus.config.npc[ 'model' ]                       = 'models/Barney.mdl' -- NPC model
fus.config.npc[ 'overheadText' ]                = 'Supervisor' -- Overhead text
fus.config.npc[ 'overheadTextColor' ]           = Color( 25, 25, 255 ) -- Color of the text above the NPC
fus.config.npc[ 'overheadTextHide' ]            = 400 -- Distance the overhead text stops displaying (for optimization)

--
-- Client-side Configuration
-- These are used for the menu n shit :D
--

fus.config.client                               = {} -- Don't touch this :D
fus.config.client[ 'backgroundColor' ] 		= Color( 15, 15, 15, 200 ) -- Background colors
fus.config.client[ 'linesColor' ] 			= Color( 255, 255, 255 ) -- Outlines colors
fus.config.client[ 'buttonsColor' ] 		= Color( 255, 25, 25, 125 ) -- Color of buttons
fus.config.client[ 'textColor' ]			= Color( 255, 255, 255 ) -- Color of text within the menus
fus.config.client[ 'animSpeed' ] 			= 0.3 -- Animation speed, 0.1 being the fastest, and 1 being the slowest
fus.config.client[ 'undercoverBarColor' ]       = Color( 25, 255, 25, 150 ) -- Color of the bar displayed when the player goes undercover.

--
-- Translations
-- Notification translations n shit like dat
--

fus.config.translate                            = {}
fus.config.translate[ 'wrongGroup' ]            = "You aren't in the correct group to go undercover as this role!" -- message to the player when they aren't the correct group to use an undercover job
fus.config.translate[ 'wrongJob' ]              = "You are not authorized for this role." -- Message to player when they aren't the correct team to use an undercover job!
fus.config.translate[ 'alreadyUndercover' ]     = 'You are already undercover.' -- Message to the player when they try using the undercover system while already undercover
fus.config.translate[ 'undercoverBegin' ]       = 'You are now on actively undercover as a %name.' -- Message when they go undercover ( %name is replaced with the job name. Required. )
fus.config.translate[ 'undercoverEnd' ]         = 'You are no longer undercover!' -- Message to the player when the undercover time ends!
fus.config.translate[ 'select' ]                = 'Select' -- Button in the menu that selects the job!
fus.config.translate[ 'cantUseAsJob' ]          = "You are not authorized for investigations or active duty."
fus.config.translate[ 'stillCooldown' ]         = "Please wait. There is a cooldown period between assignments (5 minutes)."
fus.config.translate[ 'cantChangeTeams' ]       = 'You can not change teams while you are undercover.'
