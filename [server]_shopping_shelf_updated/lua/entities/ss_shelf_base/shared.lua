--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/entities/ss_shelf_base/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = 'anim'
ENT.Base = 'base_gmodentity'

ENT.PrintName = "Shopping shelf - Base"
ENT.Author      = "Icefuse Networks"
ENT.Category	= "Icefuse - Shopping shelfs"

ENT.Spawnable = false

--[[
-
]]
function ENT:initItemSlots()

end

--[[
- @param table options
]]
function ENT:addItemSlot(options)

	if type(options) ~= 'table' then
		return
	end

	options.entity = options.entity or {}
	options.label = options.label or {}

	local index = table.insert(self._itemSlots, {
		entity = {
			pos = options.entity.pos or Vector(0, 0, 0),
			ang = options.entity.ang or Angle(0, 0, 0)
		},
		label = {
			pos = options.label.pos or Vector(0, 0, 0),
			ang = options.label.ang or Angle(0, 0, 0),
			align = options.label.align or 'center'
		}
	})

	table.insert(self._openItemSlots, index)
	
end

--[[
- @return bool
]]
function ENT:hasCashRegistry()
	return IsValid(self:getCashRegistry())
end

--[[
- @return entity|nil
]]
function ENT:getCashRegistry()

	if not IsValid(self._cashRegistry) or self._cashRegistry:GetPos():DistToSqr(self:GetPos()) > 900 ^ 2 then
		self._cashRegistry = self:findCashRegistry()
	end

	return self._cashRegistry
end

--[[
- @return entity|nil
]]
function ENT:findCashRegistry()
	local owner = self:CPPIGetOwner()

	local entities = {}
	for _, entity in ipairs (ents.FindByClass('ss_cash_registry')) do

		if entity:CPPIGetOwner() ~= owner then
			continue
		end

		if entity:GetPos():DistToSqr(self:GetPos()) > 900 ^ 2 then
			continue
		end

		return entity
	end

	return nil
end
