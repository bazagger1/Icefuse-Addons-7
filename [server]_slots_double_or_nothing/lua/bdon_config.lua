--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_slots_double_or_nothing/lua/bdon_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--[[-------------------------------------------------------------------------
Read me first!
---------------------------------------------------------------------------]]
--[[
	Its important to test your slot machines to make sure they fit with your economy.
	Settings the chance to high can and will ruin it if you dont have it configured properly.

	To save slots you simple type !saveslots, to remove them just remove them from the map and do !saveslots again.

	If you have any questions please open a support ticket and i'll answer as soona I see it

	Thanks for purchasing, enjoy your slots :)

	The WORKSHOP link is here : http://steamcommunity.com/sharedfiles/filedetails/?id=1174019751

	These commands disable or enable the screen (client side)
	bdor_disable_screens
	bdor_enable_screens
]]

--Just leave this here, you dont need to change it
BDON_CONFIG = {}

--This is the base bet amount. Change this how you please, the winnings scale with it (except for jackpot)
BDON_CONFIG.bet = 100 

--This is the minimum the jackpot can be (its random)
BDON_CONFIG.minJackpot = 25000
 
--This is the maximum the jackpot can be (its random between min-max)
BDON_CONFIG.maxJackpot = 100000

--This is the chance that the next double is either a double or nothing. the highter the number the higher the chance (% between 0 and 100)
BDON_CONFIG.doubleChance = 51 --was at 45, (50 is recommened, but if you think there winning jackpot to much then lower this number, or raise it its your server :)

--This is a list of usergroups that can save/edit the machines (!saveslots)
BDON_CONFIG.AdminRanks = {
	"superadmin",
	"c_e_o"
}

--If the sounds are too loud, you can change this. It is between 0 and 1
BDON_CONFIG.Volume = 1

--You can change this to anything, or thing. This gets added before any money amount is shown
BDON_CONFIG.CurrenyPrefix = "$"


--[[-------------------------------------------------------------------------
Below is three functions, these can be used to easily add support for any gamemode you want
This is currently configured for darkrp, if you don't know how to change this then please
open a support ticket and i'll send you the code for it.
---------------------------------------------------------------------------]]

BDON_CONFIG.addMoney = function(ply, amount)
	ply:addMoney(amount) --DarkRP
end

BDON_CONFIG.canAfford = function(ply, amount)
	return ply:canAfford(amount) --DarkRP
end

BDON_CONFIG.takeMoney = function(ply, amount)
	ply:addMoney(amount * -1) --DarkRP
end


