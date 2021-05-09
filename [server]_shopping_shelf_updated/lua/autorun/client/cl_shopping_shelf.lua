--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/autorun/client/cl_shopping_shelf.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

surface.CreateFont('ss.shelf.price', {
	font = 'DermaDefault',
	size = 48,
	weight = 500,
	antialias = true,
	shadow = false,
	italic = false
})

surface.CreateFont('ss.box.name', {
	font = 'DermaDefault',
	size = 32,
	weight = 500,
	antialias = true,
	shadow = false,
	italic = true
})

surface.CreateFont('ss.box.small', {
	font = 'DermaDefault',
	size = 24,
	weight = 500,
	antialias = true,
	shadow = false,
	italic = true
})


local cl_SS = {}
cl_SS.VGUI = {}

net.Receive('NET_SS_OpenMenu', function()

	local shelf = net.ReadEntity()
	cl_SS.OpenMenu(shelf)

end)

function cl_SS.OpenMenu(shelf)

	local client = LocalPlayer()

	local cartItems = {}
	local cartCost = 0

	frame = vgui.Create('DFrame')
	frame:SetSize( 600, 400 )
	frame:Center()
	frame:MakePopup()
	frame:SetTitle( 'Player Shop' )
	frame.lblTitle:SetFont('DermaDefaultBold')
	frame.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255, 15) )     -- Background white line
		draw.RoundedBox( 0, 1, 1, w-2, h-2, Color(10, 10, 10, 245) )   -- Background

		surface.SetDrawColor( Color( 30, 78, 92, 245 ) )               -- Blue Outline       
		surface.DrawOutlinedRect( 5, 50, 292, 310 )           

		surface.SetDrawColor( Color( 3, 109, 35, 245 ) )               -- Green Outline   
		surface.DrawOutlinedRect( 302, 50, 292, 310 )

	end

	local CartLabel = vgui.Create("DLabel", frame )
	CartLabel:SetFont("Trebuchet24")
	CartLabel:SetText("Cart")
	CartLabel:SetPos( 5, 24 )
	CartLabel:SetColor( Color( 255, 255, 255, 255 ) )                 -- Cart text color
	CartLabel:SizeToContents()

	local ShelfLabel = vgui.Create("DLabel", frame )
	ShelfLabel:SetFont("Trebuchet24")
	ShelfLabel:SetText("Shelf")
	ShelfLabel:SetPos( 300, 24 )
	ShelfLabel:SetColor( Color( 255, 255, 255, 255 ) )                 -- shelf text color
	ShelfLabel:SizeToContents()

	local cartListScroll = vgui.Create( "DScrollPanel", frame )
	cartListScroll:SetSize( 292, 310 )
	cartListScroll:SetPos( 5, 50 )

	local itemListScroll = vgui.Create( "DScrollPanel", frame )
	itemListScroll:SetSize( 292, 310 )
	itemListScroll:SetPos( 302, 50 )

	-- local CartList = vgui.Create( "DIconLayout", cartListScroll )
	-- CartList:SetSize( 292, 310 )
	-- CartList:SetSpaceY( 1 )
	-- CartList:SetSpaceX( 0 )
	-- CartList.ListName = "CartList"
	-- CartList:Receiver( "ShopItems", cl_SS.MoveItem )
	--
	-- local ItemList = vgui.Create( "DIconLayout", itemListScroll )
	-- ItemList:SetSize( 292, 310 )
	-- ItemList:SetSpaceY( 1 )
	-- ItemList:SetSpaceX( 0 )
	-- ItemList.ListName = "ItemList"
	-- ItemList:Receiver( "ShopItems", cl_SS.MoveItem )

	local LeftPanel = vgui.Create("DPanel", frame )
	LeftPanel:SetSize( 292, 30 )
	LeftPanel:SetPos( 5, 365 )
	LeftPanel:SetBackgroundColor( Color( 30, 78, 92, 245 ) )                -- Bottom Blue Left Bottom Cart

	local RightPanel = vgui.Create( "DPanel", frame )
	RightPanel:SetSize( 292, 30 )
	RightPanel:SetPos( 302, 365 )
	RightPanel:SetBackgroundColor( Color( 3, 109, 35, 245 ) )               -- Bottom Green Right Bottom Cart

	local rightTotalPrice = vgui.Create("DLabel", LeftPanel)
	rightTotalPrice:Dock( LEFT )
	rightTotalPrice:DockMargin( 10, 0, 10, 0 )
	rightTotalPrice:SetFont("DermaDefaultBold")
	rightTotalPrice:SetText("Total: $0")
	rightTotalPrice:SetColor( Color(255, 255, 255, 255) )                -- Total price text color
	rightTotalPrice:SizeToContentsX()

	-- local leftTotalPrice = vgui.Create("DLabel", RightPanel)
	-- leftTotalPrice:Dock( LEFT )
	-- leftTotalPrice:DockMargin( 10, 0, 10, 0 )
	-- leftTotalPrice:SetFont("DermaDefaultBold")
	-- leftTotalPrice:SetText("Total: $0")
	-- leftTotalPrice:SetColor( Color(255, 255, 255, 255) )
	-- leftTotalPrice:SizeToContentsX()
	--
	-- cl_SS.VGUI.TotalPriceLabel = leftTotalPrice

	local CheckoutButton = vgui.Create("DButton", LeftPanel)
	CheckoutButton:Dock( RIGHT )
	CheckoutButton:DockMargin( 10, 2, 2, 2 )
	CheckoutButton:SetWide( 100 )
	CheckoutButton:SetText( 'Check Out' )

	CheckoutButton.DoClick = function()

		if client:getDarkRPVar('money') < cartCost then
			return
		end

		if table.Count(cartItems) == 0 then
			return
		end

		local entities = {}
		for entity in pairs(cartItems) do
			table.insert(entities, entity)
		end

		net.Start('NET_SS_DoBuyTakeoffGooood')
			net.WriteEntity(shelf)
			net.WriteTable(entities)
		net.SendToServer()

		frame:Remove()

	end

	local TotalPrice = 0

	local items = table.ClearKeys(shelf._items)

	-- Sort on slot number
	table.sort(items, function(a, b)
		return a.slot < b.slot
	end)

	for _, item in ipairs(items) do

		local entity = item.entity
		local price = item.price

		if not IsValid(entity) then
			continue
		end

		local isOwner = shelf:CPPIGetOwner() == LocalPlayer()

		-- Ignore items that do not have a price yet..
		if not isOwner and price == -1 then
			continue
		end

		local setPriceButton

		local itemPanel = vgui.Create("DPanel")
		itemPanel:SetSize(292, 30)
		itemPanel:SetBackgroundColor( Color( 5, 155, 50, 325 ) )            -- Green Middle Background
		itemPanel:Dock(TOP)

		itemListScroll:AddItem(itemPanel)

		local ItemIcon = vgui.Create("DModelPanel", itemPanel)
		ItemIcon:SetSize(50, 28 )
		ItemIcon:SetModel(entity:GetModel())
		ItemIcon:SetLookAt(sh_SS.Sellables[entity:GetClass()].iconLookAt)
		ItemIcon:SetCamPos(sh_SS.Sellables[entity:GetClass()].iconCamPos)

		local class = entity:GetClass()
		local name = class

		if class == 'spawned_weapon' then
			local weaponClass = shelf:getEntityClass(entity)

			local translation = language.GetPhrase(weaponClass)
			if translation ~= weaponClass then
				name = translation
			else

				local weaponTable = weapons.GetStored(weaponClass)
				if weaponTable ~= nil then
					name = weaponTable.PrintName or weaponTable.Name or name
				end

			end

		elseif class == 'food' then
			name = DarkRP.getPhrase("Food")
		end

		local ItemNameLabel = vgui.Create("DLabel", itemPanel)
		ItemNameLabel:SetFont("DermaDefaultBold")
		ItemNameLabel:SetText(name)
		ItemNameLabel:SetPos(60, 2)
		ItemNameLabel:SetColor( Color(255, 255, 255, 255) )
		ItemNameLabel:SizeToContents()

		local ItemPriceLabel = vgui.Create("DLabel", itemPanel)
		ItemPriceLabel:SetFont("DermaDefault")
		ItemPriceLabel:SetText(price == -1 and "$--" or "$" .. string.Comma(price))
		ItemPriceLabel:SetPos(60, 15)
		ItemPriceLabel:SetColor( Color(255, 255, 255, 255) )
		ItemPriceLabel:SizeToContents()

		local moveBtn = vgui.Create( "DButton", itemPanel )
		moveBtn:Dock( RIGHT )
		moveBtn:DockMargin( 2, 4, 4, 4 )
		moveBtn:SetWide(55)
		moveBtn:SetText("To Cart")

		if price == -1 then
			moveBtn:SetDisabled(true)
		end

		moveBtn.DoClick = function()

			if itemPanel:GetParent():GetParent() == itemListScroll then
				-- Add...

				if price <= -1 then
					return
				end

				moveBtn:SetText("Remove")

				itemPanel:SetBackgroundColor(Color(8, 103, 130, 245))   -- Blue Item Background
				cartListScroll:AddItem(itemPanel)

				cartItems[entity] = true
				cartCost = cartCost + price

				if setPriceButton then
					setPriceButton:SetDisabled(true)
				end

			else
				-- Remove...

				moveBtn:SetText("To Cart")

				itemPanel:SetBackgroundColor( Color( 170, 136, 1, 245 ) )
				itemListScroll:AddItem(itemPanel)

				cartItems[entity] = nil
				cartCost = cartCost - price

				if setPriceButton then
					setPriceButton:SetDisabled(false)
				end

			end

			rightTotalPrice:SetText("Total: $" .. cartCost)
			rightTotalPrice:SizeToContents()

			if cartCost > client:getDarkRPVar('money') then
				rightTotalPrice:SetColor(Color(205, 0, 0, 255))
			else
				rightTotalPrice:SetColor(Color(255, 255, 255, 255))
			end

			for _, child in pairs(itemListScroll:GetCanvas():GetChildren()) do
				child:SetPos(0, 0)
				child:Dock(TOP)
			end
			
			for _, child in pairs(cartListScroll:GetCanvas():GetChildren()) do
				child:SetPos(0, 0)
				child:Dock(TOP)
			end

		end

		if shelf:CPPIGetOwner() == LocalPlayer() then

			setPriceButton = vgui.Create("DNumberWang", itemPanel)
			setPriceButton:Dock( RIGHT )
			setPriceButton:DockMargin( 2, 5, 4, 5 )
			setPriceButton:SetWide(55)
			setPriceButton:SetPos(160, 5)
			setPriceButton:SetText(price == -1 and "--" or price)

			setPriceButton.OnFocusChanged = function(pnl, gained)

				local price = pnl:GetValue()
				if tonumber(pnl:GetText()) == nil or pnl:GetValue() < 0 then
					pnl:SetText(gained and "" or "--")
					price = -1
				end

				if not gained then

					moveBtn:SetDisabled(price == -1)

					net.Start('NET_SS_DoSetPrice')
						net.WriteEntity(shelf)
						net.WriteEntity(entity)
						net.WriteInt(price, 32)
					net.SendToServer()

					if price == -1 then
						ItemPriceLabel:SetText("$--")
					else
						ItemPriceLabel:SetText("$" .. string.Comma(price))
					end
					ItemPriceLabel:SizeToContents()

				end

			end

		end

	end

end
