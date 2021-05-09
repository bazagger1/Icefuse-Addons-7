--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_steam_group_rewards/lua/realgroup_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

RealGroup = {Rewards = {},Window = {},Chat = {}} -- Ignore
--[[

     RealGroup; By Velkon.
     Reward your players for joining your group!

]]

RealGroup.GroupURLID = "Icefuse-Networks" -- This is the GroupURLID, it is the part after the "/groups/" in the URL.
RealGroup.GroupID = '103582791435790645' -- This is the GroupURLID, it is the part after the "/groups/" in the URL.

-- Eg. This one would be at: http://steamcommunity.com/groups/glua

RealGroup.Time = 15
-- Seconds that the player has to join the group from clicking Yes.

RealGroup.Popup = true
-- Popup the group invite when the player fully loads?

RealGroup.ChatCommand = "!steam" 
-- The chat command to popup the group menu.

--[[

     Chat portion of the addon. This is pretty self explanitory.

]]

RealGroup.Chat.Tag = "Steam Group"
-- The chat tag in all the messages.

RealGroup.Chat.Checking = "Checking group invite in " .. RealGroup.Time .. " seconds!"
-- The chat message that shows up when they decide click yes.

RealGroup.Chat.TimesUpCheck = "Checking group invite..."
-- The chat message that shows up when the time is up, and the server checks if they joined.

RealGroup.Chat.Reward = "Thank you for joining! You have been awarded 5,000 in game cash and our exclusive membership rank!"
-- The chat message that shows up when they get checked and they are in the group.

RealGroup.Chat.NotInGroup = "Looks like you didn't join the group! You can try again."
-- The chat message that shows up when the time is up, but they are not in the group.



--[[

     This is the ingame window section, It's pretty self explanitory.

]]

RealGroup.Window.Title = "Steam Group Membership"
-- The title of the window.

-- RealGroup.Window.Body = "Hello, welcome to Icefuse Networks! \n\nIn order to play our server fully, we require you join our steam group \n\nYou will recieve 5,000 in game cash and our exclusive membership rank upon joining! \n\nThanks for playing Icefuse Networks Servers!"

RealGroup.Window.Body = "Hello, welcome to Icefuse Networks! To play our server to its full potential, we require you join our steam group \n\nYou will recieve the following rewards; 5,000 in game cash, increased prop limit from 15 to 35, access to unique tools such as an advanced duplicator, access to vehicles and our exclusive membership rank with much more! \n\nThank you for playing Icefuse Networks!"







-- This is the body text of the window, you can use "\n" for a new line.

RealGroup.Window.Yes = "Yes"
-- The yes button.

RealGroup.Window.No = "No"
-- The no button.


--[[

     This is the rewards section.

     Leave something to 0, If it's an integer; or "" if it's a string.
     To disable.

     If you do not have the addon, then just ignore and leave at default.

]]

RealGroup.Rewards.PS1 = 0
-- Pointshop 1 points to give to the player.

RealGroup.Rewards.PS2Premium = 0
-- Premium Pointshop 2 points to give to the player.

RealGroup.Rewards.PS2Standard = 0
-- Standard Pointshop 2 points to give to the player.

RealGroup.Rewards.DarkRPMoney = 5000
-- Darkrp money to give to the player.

RealGroup.Rewards.ULXRank = "member"
-- ULX Rank to set player to.

-- Whether we want to set the ulx rank for the player
RealGroup.Rewards.shouldSetULXRank = function(ply)
	return ply:GetUserGroup () == 'user'
end

-- These are permaweapons, formatted as a table.
-- Format is "classname",
RealGroup.Rewards.PermWeapons = {
     --"weapon_357",
     --"weapon_stunstick",
     
}

RealGroup.Rewards.Custom = function(ply)
end
-- This is for custom rewards, if you are experienced with lua.



print("Loaded realgroup config.")
