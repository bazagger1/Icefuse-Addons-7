--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_slots_double_or_nothing/lua/entities/double_or_nothing/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Double Or Nothing"
ENT.Author = "<CODE BLUE>"
ENT.Contact = "Via Steam"
ENT.Spawnable = true
ENT.Category = "Icefuse Casino"
ENT.AdminSpawnable = true 

ENT.WheelSides = 8

function ENT:SetupDataTables()
	--Stores the current user name of the machine.
	--Will be "No One" if one one is using it.
	self:NetworkVar( "String", 0, "UserName")
	self:NetworkVar( "Float", 0, "UserLastInteract")
	self:NetworkVar( "Int", 0, "Multiplier")
	self:NetworkVar( "Bool", 0, "GameStarted")
	self:NetworkVar( "Int", 1, "CashOutAmount")
	self:NetworkVar( "Int", 2, "Jackpot")
end