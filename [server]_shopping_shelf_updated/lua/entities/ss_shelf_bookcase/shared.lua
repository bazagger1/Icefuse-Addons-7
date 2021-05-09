--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/entities/ss_shelf_bookcase/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Base = 'ss_shelf_base'

ENT.PrintName = "Bookcase"
ENT.Author      = "Icefuse Networks"
ENT.Category	= "Icefuse Store/Merchant"

ENT.Spawnable = true
ENT.AdminOnly = true

--[[
- @inheritdoc
]]
function ENT:initItemSlots()

	self:addItemSlot({
		entity = {
			pos = Vector( 17, 7, 4 )
		},
		label = {
			pos = Vector( 17, 7, 4 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -18, 5, 4)
		},
		label = {
			pos = Vector( -18, 5, 4) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 17, 7, 24 )
		},
		label = {
			pos = Vector( 17, 7, 24 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -18, 5, 24 )
		},
		label = {
			pos = Vector( -18, 5, 24 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 17, 7, 43 )
		},
		label = {
			pos = Vector( 17, 7, 43 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -18, 5, 43 )
		},
		label = {
			pos = Vector( -18, 5, 43 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 17, 7, 60.5 )
		},
		label = {
			pos = Vector( 17, 7, 60.5 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -18, 5, 60.5 )
		},
		label = {
			pos = Vector( -18, 5, 60.5 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 17, 7, 78 )
		},
		label = {
			pos = Vector( 17, 7, 78 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -18, 5, 78 )
		},
		label = {
			pos = Vector( -18, 5, 78 ) + Vector(-18, 3, 3),
			ang = Angle(0, 180, 90),
			align = 'right'
		}
	})

end
