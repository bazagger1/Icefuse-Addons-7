--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_trashcan_system/lua/autorun/sh_nautboxesconfig.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if (SERVER) then

	AddCSLuaFile()

end

shBoxesConfig = {}

// Feel free to edit below! //

shBoxesConfig.drawDistance 						    = 850 	// How far away should dumpsters and chests render? (gmod units)(saves fps)
shBoxesConfig.dumpsterSearchTime					= 5 	// How long does it take to search a dumpster? (seconds)
shBoxesConfig.dumpsterCoolDown 						= 15 	// How long before a dumpster can be searched again? (seconds)
shBoxesConfig.dumpsterBadLootProbability 	        = 98 	// (0->100)% chance of a player getting bad loot (percentage)
shBoxesConfig.dumpsterGoodLootProbability           = 2	// (0->100)% chance of a player getting good loot (percentage)

shBoxesConfig.chestSpawnProbability 			    = 20	// (0->100)% chance of a chest spawning (percentage)
shBoxesConfig.chestSpawnTimer 						= 120 // Time inbetween chest spawn calculations (seconds)
shBoxesConfig.chestSearchTime 						= 10 	// How long does it take to open a chest? (seconds)


shBoxesConfig.chestLoot 									= {
	"drilldo",
	"weapon_cuff_elastic",
	"weapon_angryhobo",
	"weapon_dumbbell",
	"grapplehookv2",
	"weapon_nomad",
	"weapon_popcorn",
	"bank_drill",
	"icefuse_keypad_cracker",
	"icefuse_lockpick",
	"icefuse_master_keypad_cracker",
	"icefuse_master_lockpick",
	"m9k_damascus",
	"marcianito",
	"weapon_fists",
	"slappers",
}

shBoxesConfig.dumpsterTeams 							= {
	"Hobo"
}
 
-- shBoxesConfig.dumpsterfailmessage = { "Fuck off you monkey" } -- Corvezeo's attempt
shBoxesConfig.failMessages = {
	["cooldown"] = "Dumpster seems to be empty.",
	["in-use"] = "Dumpster is already being searched by another player.",
	["incorrect-team"] = "I should not be acting like a hobo."
}

shBoxesConfig.dumpsterBadLoot 						= {

	"swep_extinguisher",
-----------------------------------------
-----------------------------------------
	-- "npc_headcrab",
	-- "npc_zombie",
	-- "npc_headcrab",
-----------------------------------------
-----------------------------------------
	"icefuse_food_bananna",
	"icefuse_food_cactus",
	"icefuse_food_dick",
	"icefuse_food_fish_01",
	"icefuse_food_fish_02",
	"icefuse_food_human_skull",
	"icefuse_food_orange",
	
-----------------------------------------
-----------------------------------------
	"durgz_alcohol",
	"durgz_aspirin",
	"durgz_cigarette",
	"durgz_cocaine",
	"durgz_heroine",
	"durgz_lsd",
	"durgz_weed",
	"durgz_meth",
	"durgz_mushroom",
	"durgz_water",
-----------------------------------------
-----------------------------------------
	"m9k_luger",
	"m9k_model627",
	"m9k_model3russian",

-----------------------------------------
}

shBoxesConfig.dumpsterGoodLoot 						= {

-----------------------------------------
-----------------------------------------
	-- "npc_headcrab_fast",
	-- "npc_fastzombie",
	-- "npc_fastzombie_torso",
	-- "npc_poisonzombie",
	
	-- "npc_antlion",
	-- "npc_antlionguard",
-----------------------------------------
-----------------------------------------
	"icefuse_food_burger",
	"icefuse_food_cactus",
	"icefuse_food_donut",
	"icefuse_food_hotdog",
	"icefuse_food_orange",
	"icefuse_food_watermelon",
-----------------------------------------
-----------------------------------------
	"m9k_deagle",
	"m9k_glock",
	"m9k_usp",
	"m9k_hk45",
	"m9k_colt1911",
	"m9k_coltpython",
	"m9k_m29satan",
	"m9k_m92beretta",
	"m9k_ragingbull",
	"m9k_scoped_taurus",
	"m9k_remington1858",
	"m9k_model500",
	"m9k_sig_p229r",
	
-----------------------------------------
-----------------------------------------
	"m9k_winchester73",
	"m9k_acr",
	"m9k_ak47",
	"m9k_ak74",
	"m9k_amd65",
	"m9k_an94",
	"m9k_val",
	"m9k_f2000",
	"m9k_famas",
	"m9k_fal",
	"m9k_g36",
	"m9k_m416",
	"m9k_g3a3",
	"m9k_l85",
	"m9k_m14sp",
	"m9k_m16a4_acog",
	"m9k_m4a1",
	"m9k_scar",
	"m9k_vikhr",
	"m9k_auga3",
	"m9k_tar21",
-----------------------------------------
	"m9k_ares_shrike",
	"m9k_fg42",
	"m9k_minigun",
	"m9k_m1918bar",
	"m9k_m249lmg",
	"m9k_m60",
	"m9k_pkm",
-----------------------------------------
	"m9k_honeybadger",
	"m9k_bizonp19",
	"m9k_smgp90",
	"m9k_mp5",
	"m9k_mp7",
	"m9k_ump45",
	"m9k_usc",
	"m9k_kac_pdw",
	"m9k_vector",
	"m9k_magpulpdr",
	"m9k_mp40",
	"m9k_mp5sd",
	"m9k_mp9",
	"m9k_sten",
	"m9k_tec9",
	"m9k_thompson",
	"m9k_uzi",
-----------------------------------------
}

shBoxesConfig.dumpsterSearchSounds 				= {		// What kind of sounds should the dumpster make when being searched?

	"ambient/materials/bump1.wav",
	"ambient/materials/shuffle1.wav",
}

shBoxesConfig.dumpsterGoodLootSound 			= {		// What kind of sounds should the player make when they get good loot?

	"vo/npc/male01/nice.wav",
	"vo/npc/male01/fantastic01.wav",
	"vo/coast/odessa/male01/nlo_cheer01.wav",
	"vo/coast/odessa/male01/nlo_cheer02.wav",
	"vo/coast/odessa/male01/nlo_cheer03.wav",
	"vo/coast/odessa/male01/nlo_cheer04.wav",
}

shBoxesConfig.dumpsterBadLootSound 				= {		// What kind of sounds should the player make when they get bad loot?

	"vo/npc/male01/ohno.wav",
	"vo/npc/Barney/ba_damnit.wav",
	"vo/npc/male01/finally.wav",
}

// DO NOT EDIT BELOW //

if (shBoxesConfig.dumpsterBadLootProbability + shBoxesConfig.dumpsterGoodLootProbability > 100) then // incase someone messes up the values

	shBoxesConfig.dumpsterGoodLootProbability = 100 - shBoxesConfig.dumpsterBadLootProbability
end

print("Loaded NautBoxes config!")
