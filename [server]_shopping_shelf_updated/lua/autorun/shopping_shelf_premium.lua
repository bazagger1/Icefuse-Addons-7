--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/autorun/shopping_shelf_premium.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sh_SS = {}
sh_SS.Config =
{
	UseCashRegistry = true,	-- Use cash registry that stores money from bought items or send money right to shelf owner?
	RobTime			= 30,		-- Amount of time in seconds it takes to rob a cash registry
}

sh_SS.Sellables = {}
-----------------------------------------------------------------
sh_SS.Sellables['spawned_weapon'] = 
{ 
	itemName = 'Weapon', 
	itemShelfPos = Vector(0, 0, 0), 
	itemShelfAng = Angle(0, 0, 90),
	iconCamPos = Vector(15, 0, 15), 
	iconLookAt = Vector(0, 0, 3), 
	dtvars = { 'WeaponClass' } 
}
-----------------------------------------------------------------
sh_SS.Sellables['heavy kevlar armor'] = 
{ 
	itemName = 'Heavy Kevlar Armor', 
	itemShelfPos = Vector(0, 0, 7), 
	itemShelfAng = Angle(0, 90, 0),
	iconCamPos = Vector(15, 0, 15), 
	iconLookAt = Vector(0, 0, 3) 
}
-----------------------------------------------------------------
sh_SS.Sellables['light kevlar armor'] = 
{ 
	itemName = 'Light Kevlar Armor', 
	itemShelfPos = Vector(0, 0, 7), 
	itemShelfAng = Angle(0, 90, 0),
	iconCamPos = Vector(15, 0, 15), 
	iconLookAt = Vector(0, 0, 3) 
}
-----------------------------------------------------------------
sh_SS.Sellables['medium kevlar armor'] = 
{ 
	itemName = 'Medium Kevlar Armor', 
	itemShelfPos = Vector(0, 0, 7), 
	itemShelfAng = Angle(0, 90, 0),
	iconCamPos = Vector(15, 0, 15), 
	iconLookAt = Vector(0, 0, 3) 
}
-----------------------------------------------------------------
sh_SS.Sellables['item_healthvial'] = 
{ 
	itemName = 'Health Vial', 
	itemShelfPos = Vector(0, 0, 7), 
	itemShelfAng = Angle(0, 90, 0),
	iconCamPos = Vector(15, 0, 15), 
	iconLookAt = Vector(0, 0, 3) 
}
-----------------------------------------------------------------
sh_SS.Sellables['item_healthkit'] = 
{ 
	itemName = 'Health Kit', 
	itemShelfPos = Vector(0, 0, 7), 
	itemShelfAng = Angle(0, 90, 0),
	iconCamPos = Vector(15, 0, 15), 
	iconLookAt = Vector(0, 0, 3) 
}
-----------------------------------------------------------------



















hook.Add( "PostGamemodeLoaded", "shoppingself", function()

	DarkRP.createEntity("Cash Registry", {
		ent = "ss_cash_registry",
		model = "models/props_c17/cashregister01a.mdl",
		price = 350,
		max = 1,
		cmd = "buyss_cash_registry",
        allowed = {TEAM_GUN_DEALER, TEAM_BLACK_MARKET_DEALER, TEAM_COOK, TEAM_DRUG_DEALER, TEAM_DOCTOR},
		sortOrder = 1,
        category = "Commercial"
	})
	
	DarkRP.createEntity("Shopping Shelf - Bookcase", {
		ent = "ss_shelf_bookcase",
		model = "models/props_c17/shelfunit01a.mdl",
		price = 500,
		max = 10,
		cmd = "buyss_shelf_bookcase",
        allowed = {TEAM_GUN_DEALER, TEAM_BLACK_MARKET_DEALER, TEAM_COOK, TEAM_DRUG_DEALER, TEAM_DOCTOR},
		sortOrder = 2,
        category = "Commercial"
	})
	
	DarkRP.createEntity("Shopping Shelf - Display Case", {
		ent = "ss_shelf_displaycase",
		model = "models/props_c17/display_cooler01a.mdl",
		price = 300,
		max = 10,
		cmd = "buyss_shelf_displaycase",
        allowed = {TEAM_GUN_DEALER, TEAM_BLACK_MARKET_DEALER, TEAM_COOK, TEAM_DRUG_DEALER, TEAM_DOCTOR},
		sortOrder = 3,
        category = "Commercial"
	})
	
	DarkRP.createEntity("Shopping Shelf - Wooden Rack", {
		ent = "ss_shelf_woodenrack",
		model = "models/props/cs_militia/shelves_wood.mdl",
		price = 1500,
		max = 10,
		cmd = "buyss_shelf_woodenrack",
        allowed = {TEAM_GUN_DEALER, TEAM_BLACK_MARKET_DEALER, TEAM_COOK, TEAM_DRUG_DEALER, TEAM_DOCTOR},
		sortOrder = 4,
        category = "Commercial"
	})
	
	DarkRP.createEntity("Shopping Shelf - Wooden Shelf", {
		ent = "ss_shelf_woodenshelf",
		model = "models/props/cs_militia/shelves.mdl",
		price = 150,
		max = 10,
		cmd = "buyss_shelf_woodenshelf",
        allowed = {TEAM_GUN_DEALER, TEAM_BLACK_MARKET_DEALER, TEAM_COOK, TEAM_DRUG_DEALER, TEAM_DOCTOR},
		sortOrder = 5,
        category = "Commercial"
	})

end)