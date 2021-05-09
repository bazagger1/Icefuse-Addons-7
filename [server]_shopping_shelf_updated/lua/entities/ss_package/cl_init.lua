--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_shopping_shelf_updated/lua/entities/ss_package/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH

--[[
-
]]
function ENT:Initialize()
	self.IsPackage = true
end

--[[
-
]]
function ENT:Draw()
	self:DrawModel()
end

--[[
-
]]
function ENT:DrawTranslucent()
	local client = LocalPlayer()
	local owner = self:CPPIGetOwner()

	if not IsValid(client) or not IsValid(owner) then
		return
	end

	local scale = self:GetModelScale()

	if self:GetPos():DistToSqr(client:EyePos()) > (150 + 300 * scale) ^ 2 then
		return
	end

	local pos = self:GetPos()
	pos = pos + self:GetUp() * (scale * 12)
	pos = pos + self:GetForward() * (scale * -14.5)
	pos = pos + self:GetRight() * (scale * 17)

	local angle = self:GetAngles()
	angle:RotateAroundAxis(angle:Up(), 90)

	cam.Start3D2D(pos, angle, .1 * scale)

		surface.SetTextColor(255, 255, 255, 200)

		surface.SetFont('ss.box.small')
		surface.SetTextPos(0, 0)
		surface.DrawText("purchased by")

		surface.SetFont('ss.box.name')
		surface.SetTextPos(0, 30)
		surface.DrawText(owner:Nick())

	cam.End3D2D()

end

-- --[[
-- -
-- ]]
-- function ENT:DrawTranslucent()
-- 	local sysTime = SysTime()
--
-- 	local pos = self:GetPos()
-- 	pos = pos + Vector(0, 0, 10 + (self:GetModelScale() * 20) + 2.5 * math.sin(sysTime * 1))
--
-- 	local angle = self:GetAngles()
--
-- 	angle.roll = 90
--   	angle.yaw  = 360 * (sysTime * .2 % 1)
--   	angle.pitch = 0
--
-- 	surface.SetFont('ss.3d.small')
--
-- 	cam.Start3D2D(pos, angle, .075)
--
-- 		local text = "Owned by " .. self:CPPIGetOwner():Nick()
-- 		local textW, textH = surface.GetTextSize(text)
--
-- 		surface.SetDrawColor(25, 25, 25, 100)
-- 		surface.DrawRect(- textW * .5 - 20 , -10, textW + 40, textH + 20)
--
-- 		surface.SetTextColor(200, 200, 200, 255)
-- 		surface.SetFont('ss.3d.small')
-- 		surface.SetTextPos(- textW * .5, 0)
-- 		surface.DrawText(text)
--
-- 	cam.End3D2D()
--
-- end
