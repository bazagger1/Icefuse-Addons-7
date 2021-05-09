--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/entities/ss_cash_registry/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

local cl_CR = {}

function ENT:Initialize()
	self.IsCashRegistry = true
	self.StoredMoney = 0
	self.Rober = nil
	self.RobProgress = 0
end

function ENT:Draw()
	self:DrawModel()

	local client = LocalPlayer()
	if not IsValid(client) then
		return
	end

	if client:EyePos():DistToSqr(self:GetPos()) > 300 ^ 2 then
		return
	end

	local pos = self:GetPos()
	local angle = self:GetAngles()

	pos = pos + self:GetUp() * 11.3
	pos = pos + self:GetForward() * 8.5

	angle:RotateAroundAxis(angle:Forward(), 90)
	angle:RotateAroundAxis(angle:Right(), 180)

	cam.Start3D2D(pos + angle:Up() * -5.5, angle, 0.077)

		surface.SetFont('DermaLarge')
		surface.SetTextColor(200, 200, 200, 255)
		surface.SetTextPos(0, 0)
		surface.DrawText("$" .. string.Comma(self.StoredMoney))

	cam.End3D2D()

end

function cl_CR.ReceiveInfo()
	local CashRegistry = net.ReadEntity()
	CashRegistry.StoredMoney = net.ReadInt(32)
end
net.Receive("NET_SS_StoredMoney", cl_CR.ReceiveInfo)

-- 76561198043317083

function cl_CR.ReceiveRobingInfo()
	local CashRegistry = net.ReadEntity()
	CashRegistry.Rober = net.ReadEntity()
	CashRegistry.RobProgress = net.ReadInt(32)
end
net.Receive("NET_CR_RobInfo", cl_CR.ReceiveRobingInfo)

function cl_CR.DrawRegistryInfo()
	if LocalPlayer():GetEyeTrace().Entity.IsCashRegistry then
		local Registry = LocalPlayer():GetEyeTrace().Entity

		local Dist = LocalPlayer():GetPos():Distance(Registry:GetPos())
		local Pos = Registry:GetPos():ToScreen()
		if Dist < 300 then
			draw.SimpleTextOutlined( "Cash Registry (Use to Open Menu)", "DermaDefaultBold", Pos.x, Pos.y, Color(5, 155, 50, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255) )
			draw.SimpleTextOutlined( "Owned by ".. (IsValid(Registry:CPPIGetOwner()) and Registry:CPPIGetOwner():Nick() or ""), "DermaDefaultBold", Pos.x, Pos.y+15, Color(170, 136, 1, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255) )
			if Registry.Rober != nil then
				if Registry.Rober:IsValid() then
					draw.SimpleTextOutlined( "Being robbed by "..Registry.Rober:Nick().." ("..Registry.RobProgress.."%)", "DermaDefaultBold", Pos.x, Pos.y+30, Color(153, 28, 28, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255) )
				end
			end
		end
	end
end
hook.Add( "HUDPaint", "DrawRegistryInfo", cl_CR.DrawRegistryInfo )

function cl_CR.OpenMenu()
	local Registry = net.ReadEntity()

	local Menu = vgui.Create("DFrame")
	Menu:SetSize(180, 82)
	Menu:Center()
	Menu:MakePopup()
	Menu:SetTitle('Cash Registry')
	Menu.lblTitle:SetColor(Color(255, 255, 255, 200))
	Menu.lblTitle:SetFont('DermaDefaultBold')
	Menu.Paint = function()
		draw.RoundedBox( 6, 0, 0, Menu:GetWide(), Menu:GetTall(), Color(255, 255, 255, 150) )
		draw.RoundedBox( 6, 1, 1, Menu:GetWide()-2, Menu:GetTall()-2, Color(10, 10, 10, 245) )
	end

	local RobButton = vgui.Create('DButton', Menu)
	RobButton:SetPos( 5, 24 )
	RobButton:SetSize( 170, 25 )
	RobButton:SetText('Start robbing')
	RobButton.DoClick = function()
		net.Start('NET_CR_StartRobing')
			net.WriteEntity( Registry )
		net.SendToServer()
		Menu:Close()
	end

	local TakeMoneyButton = vgui.Create('DButton', Menu)
	TakeMoneyButton:SetPos( 5, 51 )
	TakeMoneyButton:SetSize( 170, 25 )
	TakeMoneyButton:SetText('Take stored money')
	TakeMoneyButton.DoClick = function()
		net.Start('NET_CR_TakeStoredMoney')
			net.WriteEntity( Registry )
		net.SendToServer()
		Menu:Close()
	end

	if Registry:CPPIGetOwner() == LocalPlayer() then
		--RobButton:SetEnabled(false)
	else
		TakeMoneyButton:SetEnabled(false)
	end
end
net.Receive('NET_SS_CashRegOpenMenu', cl_CR.OpenMenu)
