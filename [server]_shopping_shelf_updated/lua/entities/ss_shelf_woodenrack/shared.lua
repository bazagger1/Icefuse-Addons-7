--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/entities/ss_shelf_woodenrack/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Base = 'ss_shelf_base'

ENT.PrintName = "Wooden rack"
ENT.Author      = "Icefuse Networks"
ENT.Category	= "Icefuse Store/Merchant"

ENT.Spawnable = true
ENT.AdminOnly = true

--[[
- @inheritdoc
]]
function ENT:initItemSlots()

	-- Bottom front
	self:addItemSlot({
		entity = {
			pos = Vector( -13, 38, 27 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, 38, 27 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -13, -4, 27 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, -4, 27 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -13, -46, 27 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, -46, 27 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})

	-- Bottom back
	self:addItemSlot({
		entity = {
			pos = Vector( 2, 38, 27 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, 38, 27 ) + Vector(11.5, 21.5, 3),
			ang = Angle(0, -90, 90),
			align = 'left'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 2, -4, 27 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, -4, 27 ) + Vector(11.5, 21.5, 3),
			ang = Angle(0, -90, 90),
			align = 'left'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 2, -46, 27 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, -46, 27 ) + Vector(11.5, 21.5, 3),
			ang = Angle(0, -90, 90),
			align = 'left'
		}
	})

	-- Middle front
	self:addItemSlot({
		entity = {
			pos = Vector( -13, 38, 59 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, 38, 59 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -13, -4, 59 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, -4, 59 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -13, -46, 59 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, -46, 59 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})

	-- Middle back
	self:addItemSlot({
		entity = {
			pos = Vector( 2, 38, 59 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, 38, 59 ) + Vector(11.5, 21.5, 3),
			ang = Angle(0, -90, 90),
			align = 'left'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 2, -4, 59 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, -4, 59 ) + Vector(11.5, 21.5, 3),
			ang = Angle(0, -90, 90),
			align = 'left'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 2, -46, 59 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, -46, 59 ) + Vector(11.5, 21.5, 3),
			ang = Angle(0, -90, 90),
			align = 'left'
		}
	})


	-- Top front
	self:addItemSlot({
		entity = {
			pos = Vector( -13, 38, 90 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, 38, 90 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -13, -4, 90 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, -4, 90 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( -13, -46, 90 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( -13, -46, 90 ) + Vector(-1.5, -14.5, 3),
			ang = Angle(0, -90, 90),
			align = 'right'
		}
	})

	-- Top back
	self:addItemSlot({
		entity = {
			pos = Vector( 2, 38, 90 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, 38, 90 ) + Vector(-2, 3, 10),
			ang = Angle(0, -90, 90),
			align = 'center'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 2, -4, 90 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, -4, 90 ) + Vector(-2, 3, 10),
			ang = Angle(0, -90, 90),
			align = 'center'
		}
	})
	self:addItemSlot({
		entity = {
			pos = Vector( 2, -46, 90 ),
			ang = Angle( 0, 90, 0 )
		},
		label = {
			pos = Vector( 2, -46, 90 ) + Vector(-2, 3, 10),
			ang = Angle(0, -90, 90),
			align = 'center'
		}
	})

end
