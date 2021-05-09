--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_slots_machine/lua/entities/wheel_of_luck/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Wheel Of Luck"
ENT.Author = " "
ENT.Contact = " "
ENT.Spawnable = true
ENT.Category = "Icefuse Casino"
ENT.AdminSpawnable = true

ENT.AutomaticFrameAdvance = true

ENT.WheelSides = 8

//A table that can convert an id to a string value, this is to check if someone wins
local idToString = {}
idToString[1] = "bonus"
idToString[2] = "raspberry"
idToString[3] = "coins"
idToString[4] = "diamond"
idToString[5] = "bar2"
idToString[6] = "bar"
idToString[7] = "seven"
idToString[8] = "nothing"

WOL_ITEM_CHANCE = {}

WOL_BONUS_ITEMS = {}

WOL_BONUS_ITEMS[1] = {cash = "jackpot", chance = 200} //The jackpot (Leave this here always)

local index = 2

//Used for register a new bonus item, there should be only 19.
function WOL_AddBonusItem(cashReward, chance)
	WOL_BONUS_ITEMS[index] = {cash = cashReward, chance = chance}
	index = index + 1
end

//Returns the string respresenting that ID
function WOL_IDToString(id)
	return idToString[id]
end


function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "BonusSpins" )
	self:NetworkVar( "Int", 1, "LastWin" )
	self:NetworkVar( "Entity", 1 , "ReelOne")
	self:NetworkVar( "Entity", 2 , "ReelTwo")
	self:NetworkVar( "Entity", 3 , "ReelThree")
	self:NetworkVar( "Int", 4 , "Jackpot")
end