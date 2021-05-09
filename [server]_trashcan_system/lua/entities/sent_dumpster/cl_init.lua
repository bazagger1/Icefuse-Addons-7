--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_trashcan_system/lua/entities/sent_dumpster/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

// Files
include("shared.lua")

// Vars

local boxW = 200
local boxH = 20

// Particle Emitter

-- NAUTBOXES_EMITTER = NAUTBOXES_EMITTER || ParticleEmitter(Vector(0,0,0),false)
-- local partMat = Material("materials/icon16/bullet_star.png")

// Entity
function ENT:Initialize()

	self.progress = 0
end

-- function ENT:MakeParticles(count)

	-- for i = 1,count do

		-- local part = NAUTBOXES_EMITTER:Add(partMat,self:GetPos() + Vector(math.random(-20,20),math.random(-20,20),20))
		-- part:SetVelocity(Vector(math.random(-50,50),math.random(-50,50),math.random(20,50)))
		-- part:SetDieTime(1.5)
		-- part:SetRollDelta(math.random(-3,3))
		-- part:SetStartAlpha(255)
		-- part:SetEndAlpha(0)
		-- part:SetColor(255,255,255)
		-- part:SetStartSize(3)
		-- part:SetEndSize(3)
	-- end
-- end

function ENT:Draw()

	if (self:GetPos():Distance(LocalPlayer():GetPos()) > shBoxesConfig.drawDistance) then return end

	self:DrawModel()

	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Right(),85)
	ang:RotateAroundAxis(ang:Up(),270)
	ang:RotateAroundAxis(ang:Right(),180)

	cam.Start3D2D(pos + ang:Up() * 20,ang,0.2)

		draw.SimpleTextOutlined("Dumpster","Trebuchet24",0,-20,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))
		draw.SimpleTextOutlined("Hold [E] to search","Trebuchet24",0,0,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))

		if (self:GetOnCoolDown()) then

				draw.SimpleTextOutlined("On Cooldown","Trebuchet24",0,20,Color(255,70,70,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))
		end
	cam.End3D2D()
end

function ENT:Think()
end

// Draw hud

local dots = 0
local lastDot = 0
local function DoHud()

	for k,v in pairs(ents.FindByClass("sent_dumpster")) do

		if (!v:IsValid()) then continue end

		if (v:GetSearchingPly() == LocalPlayer()) then

			// Draw searching hud
			surface.SetDrawColor(Color(30,30,30,200))
			surface.DrawRect(ScrW() / 2 - boxW / 2,ScrH() / 2 - boxH / 2,boxW,boxH)

			v.progress = Lerp(0.01,v.progress,1 - (v:GetSearchTimeLeft() / shBoxesConfig.dumpsterSearchTime))
			surface.SetDrawColor(Color(255 - (v.progress * 255),v.progress * 255,50,255))
			surface.DrawRect(ScrW() / 2 - boxW / 2,ScrH() / 2 - boxH / 2,boxW * v.progress,boxH)

			surface.SetDrawColor(Color(0,0,0,255))
			surface.DrawOutlinedRect(ScrW() / 2 - boxW / 2,ScrH() / 2 - boxH / 2,boxW,boxH)

			if (lastDot + 0.5 < CurTime()) then

				dots = dots + 1
				lastDot = CurTime()
			end

			if (dots > 3) then dots = 0 end

			local dStr = ""
			for i = 1,dots do

				dStr = dStr .. "."
			end

			draw.SimpleTextOutlined("Searching" .. dStr,"Trebuchet24",ScrW() / 2,ScrH() / 2,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))

		elseif(v:GetSearchingPly() != LocalPlayer() && v.progress != 0) then

			v.progress = 0 // reset progress var
		end
	end
end

hook.Add("HUDPaint","seent_dumpster_dohud",DoHud)

// Network

-- net.Receive("sent_dumpster_doparticles",function()

	-- local ent = net.ReadEntity()
	-- ent:MakeParticles(net.ReadUInt(16))
-- end)
