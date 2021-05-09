--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_vending_machines/lua/autorun/vm_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

VendingMachine = {}
VendingMachine.PercentagePayout = .25
VendingMachine.VIPPayoutBonus = .5 //Price of Item * 
VendingMachine.VIPPayoutBonusEnable = true
VendingMachine.SelfSupply = true
VendingMachine.VIPGroups = {
	"superadmin",
	"developer",
	"admin",
}
VendingMachine.AmmoColor = Color(255,166,0,200)
VendingMachine.ArmorColor = Color(56,167,214,200)
VendingMachine.HealColor = Color(255,20,20,200)
VendingMachine.FoodColor = Color(10, 10, 10, 210)
--VendingMachine.FoodColor = Color(19,247,124,200)
VendingMachine.AmmoMaterial = ""
VendingMachine.ArmorMaterial = ""
VendingMachine.HealMaterial = ""
VendingMachine.FoodMaterial = ""
VendingMachine.MoneyEarnSound = "garrysmod/content_downloaded.wav"
VendingMachine.Display3D2D = true
VendingMachine.Model = "models/props_interiors/VendingMachineSoda01a.mdl"


AmmoMachine = {}
AmmoMachine.Shop = {


	{printname = "357", price = 180, ammoclass = "357", worldmodel = "models/Items/357ammo.mdl", amount = 6, viponly = false},
	
	{printname = "AR2", price = 1000, ammoclass = "AR2", worldmodel = "models/Items/BoxMRounds.mdl", amount = 30, viponly = false},
	
	{printname = "Pistol", price = 45, ammoclass = "Pistol", worldmodel = "models/Items/357ammo.mdl", amount = 13, viponly = false},
	
	{printname = "SMG1", price = 100, ammoclass = "SMG1", worldmodel = "models/Items/BoxMRounds.mdl", amount = 60, viponly = false},
	
	{printname = "Buckshot", price = 200, ammoclass = "Buckshot", worldmodel = "models/Items/BoxBuckshot.mdl", amount = 12, viponly = false},
	
	{printname = "SniperRound", price = 300, ammoclass = "SniperRound", worldmodel = "models/Items/BoxSRounds.mdl", amount = 30, viponly = false},
	
	{printname = "RPG", price = 6000, ammoclass = "RPG_Round", worldmodel = "models/Items/AR2_Grenade.mdl", amount = 1, viponly = false},
	
	
	
	{printname = "357", price = 90, ammoclass = "357", worldmodel = "models/Items/357ammo.mdl", amount = 6, viponly = false},
	
	{printname = "AR2", price = 500, ammoclass = "AR2", worldmodel = "models/Items/BoxMRounds.mdl", amount = 30, viponly = false},
	
	{printname = "Pistol", price = 22, ammoclass = "Pistol", worldmodel = "models/Items/357ammo.mdl", amount = 13, viponly = false},
	
	{printname = "SMG1", price = 50, ammoclass = "SMG1", worldmodel = "models/Items/BoxMRounds.mdl", amount = 60, viponly = false},
	
	{printname = "Buckshot", price = 100, ammoclass = "Buckshot", worldmodel = "models/Items/BoxBuckshot.mdl", amount = 12, viponly = false},
	
	{printname = "SniperRound", price = 150, ammoclass = "SniperRound", worldmodel = "models/Items/BoxSRounds.mdl", amount = 30, viponly = false},
	
	{printname = "RPG", price = 3000, ammoclass = "RPG_Round", worldmodel = "models/Items/AR2_Grenade.mdl", amount = 1, viponly = false},	

}

ArmorMachine = {}
ArmorMachine.Shop = {


	{printname = "Armor", price = 100, worldmodel = "models/Items/item_item_crate.mdl", amount = 5, viponly = false},
	
	{printname = "Armor", price = 150, worldmodel = "models/Items/item_item_crate.mdl", amount = 10, viponly = false},
	
	{printname = "Armor", price = 200, worldmodel = "models/Items/item_item_crate.mdl", amount = 20, viponly = false},
	
	{printname = "Armor", price = 250, worldmodel = "models/Items/item_item_crate.mdl", amount = 35, viponly = false},
	
	{printname = "Armor", price = 300, worldmodel = "models/Items/item_item_crate.mdl", amount = 50, viponly = false},
	
	{printname = "Armor", price = 400, worldmodel = "models/Items/item_item_crate.mdl", amount = 75, viponly = false},
	
	{printname = "Armor", price = 500, worldmodel = "models/Items/item_item_crate.mdl", amount = 100, viponly = false},
	
	
	
	{printname = "Armor", price = 50, worldmodel = "models/Items/item_item_crate.mdl", amount = 5, viponly = false},
	
	{printname = "Armor", price = 100, worldmodel = "models/Items/item_item_crate.mdl", amount = 10, viponly = false},
	
	{printname = "Armor", price = 150, worldmodel = "models/Items/item_item_crate.mdl", amount = 20, viponly = false},
	
	{printname = "Armor", price = 200, worldmodel = "models/Items/item_item_crate.mdl", amount = 35, viponly = false},
	
	{printname = "Armor", price = 250, worldmodel = "models/Items/item_item_crate.mdl", amount = 50, viponly = false},
	
	{printname = "Armor", price = 300, worldmodel = "models/Items/item_item_crate.mdl", amount = 75, viponly = false},
	
	{printname = "Armor", price = 325, worldmodel = "models/Items/item_item_crate.mdl", amount = 100, viponly = false},
	

}

HealingMachine = {}
HealingMachine.Shop = {


	{printname = "Heal", price = 100, worldmodel = "models/Items/HealthKit.mdl", amount = 5, viponly = false},
	
	{printname = "Heal", price = 150,  worldmodel = "models/Items/HealthKit.mdl", amount = 10, viponly = false},
	
	{printname = "Heal", price = 200, worldmodel = "models/Items/HealthKit.mdl", amount = 20, viponly = false},
	
	{printname = "Heal", price = 250, worldmodel = "models/Items/HealthKit.mdl", amount = 35, viponly = false},
	
	{printname = "Heal", price = 300, worldmodel = "models/Items/HealthKit.mdl", amount = 50, viponly = false},
	
	{printname = "Heal", price = 400, worldmodel = "models/Items/HealthKit.mdl", amount = 75, viponly = false},
	
	{printname = "Heal", price = 500, worldmodel = "models/Items/HealthKit.mdl", amount = 100, viponly = false},
	
	
	
	{printname = "Heal", price = 50, worldmodel = "models/Items/HealthKit.mdl", amount = 5, viponly = false},
	
	{printname = "Heal", price = 100, worldmodel = "models/Items/HealthKit.mdl", amount = 10, viponly = false},
	
	{printname = "Heal", price = 150, worldmodel = "models/Items/HealthKit.mdl", amount = 20, viponly = false},
	
	{printname = "Heal", price = 200, worldmodel = "models/Items/HealthKit.mdl", amount = 35, viponly = false},
	
	{printname = "Heal", price = 250, worldmodel = "models/Items/HealthKit.mdl", amount = 50, viponly = false},
	
	{printname = "Heal", price = 300, worldmodel = "models/Items/HealthKit.mdl", amount = 75, viponly = false},
	
	{printname = "Heal", price = 325, worldmodel = "models/Items/HealthKit.mdl", amount = 100, viponly = false},
	

}

FoodMachine = {}
FoodMachine.Shop = {

	{printname = "Orange", price = 220, worldmodel = "models/props/cs_italy/orange.mdl", amount = 5, viponly = false},
	
	{printname = "Hotdog", price = 230,  worldmodel = "models/food/hotdog.mdl", amount = 6, viponly = false},
	
	{printname = "Burger", price = 240, worldmodel = "models/food/burger.mdl", amount = 7, viponly = false},
	
	{printname = "Donut", price = 250, worldmodel = "models/noesis/donut.mdl", amount = 9, viponly = false},
	
	{printname = "Chinese Food", price = 260, worldmodel = "models/props_junk/garbage_takeoutcarton001a.mdl", amount = 10, viponly = false},
	
	
}
