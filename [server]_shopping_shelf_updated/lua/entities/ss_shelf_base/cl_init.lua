--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/entities/ss_shelf_base/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH

surface.CreateFont('IcefuseShelfFont', {
	font = 'Default',
	size = 32,
	weight = 600,
	antialias = true,
	outline = true
})

local NET_SHELF = 'ss.shelf'
local NET_SHELF_ITEM = 'ss.shelf_item'

local TEXT_FADE_DISTANCE = 200 ^ 2
local TEXT_FADE_DISTANCE_LENGTH = 100 ^ 2

--------------------------------------------------

local pairs = pairs
local SysTime = SysTime

local math_sin = math.sin

local surface_SetDrawColor = surface.SetDrawColor
local surface_SetFont = surface.SetFont
local surface_SetTextColor = surface.SetTextColor

--------------------------------------------------

local cache_text = {}
local cache_textSize = {}

--------------------------------------------------

--[[
-
]]
function ENT:Initialize()

	self._itemSlots = {}
	self._openItemSlots = {} -- Only used on the server
	self:initItemSlots()

	self._cashRegistry = nil

	self._items = {}
	self._itemQueue = {}
	self._dummies = {}

	self._nextDummyCheck = 0
	self._nextItemQueueCheck = -1

	-- Request init data
	net.Start(NET_SHELF)
		net.WriteEntity(self)
		net.WriteString('init')
	net.SendToServer()

	self:onInitialized()
end

--[[
-
]]
function ENT:onInitialized()

end

--[[
- Called when the shelf is is removed.
]]
function ENT:OnRemove()

	-- Remove the dummies
	for _, dummy in pairs(self._dummies) do

		if IsValid(dummy) then
			dummy:Remove()
		end

	end

end

--[[
-
]]
function ENT:Think()

	if self._nextItemQueueCheck ~= -1 and self._nextItemQueueCheck < SysTime() then
		self._nextItemQueueCheck = SysTime() + 1

		for index, handler in pairs(self._itemQueue) do
			handler(index)
		end

		-- No items in the queue, pause
		if table.Count(self._itemQueue) == 0 then
			self._nextItemQueueCheck = -1
		end

	end

	-- Temporary fix..
	if self._nextDummyCheck < SysTime() then
		self._nextDummyCheck = SysTime() + 5

		for index, dummy in pairs(self._dummies) do

			if not IsValid(dummy) then -- Maybe?
				self._dummies[index] = nil

				return
			end

			-- May prevent ghosting?
			if dummy:GetParent() ~= self then
				dummy:SetParent(self)
				dummy:SetLocalPos(dummy._pos)
				dummy:SetLocalAngles(dummy._angle)
			end

		end

	end

end

--[[
- @param entity entity
-
- @return string
]]
function ENT:getEntityClass(entity)

	local class = entity:GetClass()
	if class == 'spawned_weapon' then
		class = entity:GetWeaponClass() or 'spawned_weapon'
	end

	return class
end

--[[
- @param entity entity
- @param CSEnt dummy
-
- @return vector, angle, string|nil
]]
function ENT:alterDummy(entity, dummy)
	local class = self:getEntityClass(entity)

	local func = self.dummyAlterations[class]
	local pos, angle, model
	if func ~= nil then
		pos, angle, model = func(dummy)
	end

	pos = pos or Vector(0, 0, 0)
	angle = angle or Angle(0, 0, 0)

	return pos, angle, model
end

--[[
- @param entity entity
- @param number slot
]]
function ENT:createDummyOnSlot(entity, slot)
	local itemSlot = self._itemSlots[slot]

	local dummy = ClientsideModel(entity:GetModel(), RENDERGROUP_OPAQUE)

	local pos, angle, model = self:alterDummy(entity, dummy)

	pos = pos + itemSlot.entity.pos
	angle = angle + itemSlot.entity.ang

	local sellable = sh_SS.Sellables[entity:GetClass()]
	if sellable then
		pos = pos + sellable.itemShelfPos
		angle = angle + sellable.itemShelfAng
	end

	if model then
		dummy:SetModel(model)
	end

	dummy:SetNoDraw(true)
	-- dummy:SetIK(false)

	dummy:SetParent(self)
	dummy:SetLocalPos(pos)
	dummy:SetLocalAngles(angle)

	dummy._pos = pos
	dummy._angle = angle

	dummy:Spawn()

	return dummy
end

--[[
- Queue's an item to be initialized.
-
- @param number index
]]
function ENT:queueItem(index)

	self._itemQueue[index] = function(index)
		local item = self._items[index]

		local entity = Entity(item.entIndex)
		if not IsValid(entity) then
			-- Wait for the entity to be valid..
			return
		end

		self._itemQueue[index] = nil

		item.entity = entity

		-- Remove dummy if already exists
		if IsValid(self._dummies[index]) then
			self._dummies[index]:Remove()
		end

		-- Create the dummy
		local dummy = self:createDummyOnSlot(entity, item.slot)
		self._dummies[index] = dummy

	end
	self._nextItemQueueCheck = 0 -- Check next tick

end

--[[
- Puts an item on the shelf.
-
- @param number index
- @param table item
]]
function ENT:putItem(index, item)
	self._items[index] = item

	self:queueItem(index, item)

end

--[[
- Puts an item on the shelf.
-
- @param number index
- @param number price
]]
function ENT:updateItemPrice(index, price)
	local item = self._items[index]

	item.price = price

end

--[[
- Removes an item from the shelf.
-
- @param number index
]]
function ENT:removeItem(index)
	self._items[index] = nil
	self._itemQueue[index] = nil

	-- Remove the dummy
	if IsValid(self._dummies[index]) then
		self._dummies[index]:Remove()
	end

end

--[[
- @param number index
-
- @return bool
]]
function ENT:itemExists(index)
	return self._items[index] ~= nil
end

--------------------------------------------------

local client

--[[ ]]
function ENT:Draw()

	-- Draw the shelf
	self:DrawModel()

	if client == nil then

		if IsValid(LocalPlayer()) then
			client = LocalPlayer()
		end

		return
	end

	--
	-- Draw the items

	-- Don't draw from a certain distance
	if client:GetPos():DistToSqr(self:GetPos()) > 1200 ^ 2 then
		return
	end

	for index in pairs(self._items) do
		local dummy = self._dummies[index]

		if not IsValid(dummy) then
			continue
		end

		dummy:DrawModel()

	end

end

--[[
-
]]
function ENT:DrawTranslucent()

	if client == nil then

		if IsValid(LocalPlayer()) then
			client = LocalPlayer()
		end

		return
	end

	--
	-- Draw item prices

	local distance = client:GetPos():DistToSqr(self:GetPos())

	-- Don't draw the price from a certain distance
	local opacity = 1 - math.max(distance - TEXT_FADE_DISTANCE, 0) / TEXT_FADE_DISTANCE_LENGTH
	if opacity <= 0.2 then
		return
	end

	surface_SetDrawColor(0, 0, 0, 120 * opacity)

	surface_SetFont('ss.shelf.price')
	surface_SetTextColor(255, 255, 255, 200 * opacity)

	local sysTime = SysTime()

	local eyePos = client:EyePos()
	local upVector = self:GetUp()
	local upAdd = upVector * math_sin(sysTime * 1)

	for index, item in pairs (self._items) do
		local itemSlot = self._itemSlots[item.slot]

		local price = item.price
		if price == -1 then
			-- Do not draw the price when not set yet
			continue
		end

		local pos = self:LocalToWorld(itemSlot.label.pos)
		local angle = self:LocalToWorldAngles(itemSlot.label.ang)
		local align = itemSlot.label.align

		pos = pos + upVector * 5 + upAdd

		-- Flip if standing behind the text
		if (pos - eyePos):Dot(angle:Up()) > 0 then
			angle:RotateAroundAxis(angle:Right(), 180)

			if align == 'right' then
				align = 'left'
			elseif align == 'left' then
				align = 'right'
			end

		end

		cam.Start3D2D(pos, angle, .06)

			local text = cache_text[price]
			if text == nil then
				if price == 0 then
					text = 	"free"
				else
					text = 	"$ " .. string.Comma(price)
				end
				cache_text[price] = text
			end

			local width = cache_textSize[price]
			if width == nil then
				width = surface.GetTextSize(text)
				cache_textSize[price] = width
			end

			local pos = nil
			if align == 'left' then
				pos = 0
			elseif align == 'right' then
				pos = -width
			else -- center
				pos = - width * .5
			end

			surface.DrawRect(pos - 15, - 2.5, width + 30, 55)

			surface.SetTextPos(pos, 0)
			surface.DrawText(text)

		cam.End3D2D()

	end

end

--------------------------------------------------
-- Networking

net.Receive(NET_SHELF, function(len)

	local shelf = net.ReadEntity()
	local action = net.ReadString()

	-- if not IsValid(shelf) then -- Currently should never be the case
	-- 	return
	-- end

	-- Server sends data for initialization of a shelf
	if action == 'init' then
		local items = net.ReadTable()

		for index, item in pairs(items) do
			shelf:putItem(index, item)
		end

	end

end)

net.Receive(NET_SHELF_ITEM, function(len)

	local shelf = net.ReadEntity()
	local action = net.ReadString()

	if not IsValid(shelf) then
		return
	end

	if action == 'put' then
		local index = net.ReadUInt(16)
		local item = net.ReadTable()

		shelf:putItem(index, item)

	elseif action == 'remove' then
		local index = net.ReadUInt(16)

		if shelf:itemExists(index) then
			shelf:removeItem(index)
		end

	elseif action == 'updatePrice' then
		local index = net.ReadUInt(16)
		local price = net.ReadInt(32)

		if shelf:itemExists(index) then
			shelf:updateItemPrice(index, price)
		end

	end

end)
