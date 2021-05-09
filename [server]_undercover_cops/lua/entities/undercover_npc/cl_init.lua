--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_undercover_cops/lua/entities/undercover_npc/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include 'shared.lua'

function ENT:Draw()

      self:DrawModel()

      if self:GetPos():Distance( LocalPlayer():GetPos() ) > fus.config.npc[ 'overheadTextHide' ] then return end

      local hop               = math.abs( math.cos( CurTime() * 1 ) )
      local pos               = self:GetPos() + Vector( 0, 0, 84 + hop * 15 )
      local ang               = Angle( 0, LocalPlayer():EyeAngles().y - 90, 90 )

      cam.Start3D2D( pos, ang, 0.1 )
            draw.SimpleText( fus.config.npc[ 'overheadText' ], 'fus_font_130', 0, 0, fus.config.npc[ 'overheadTextColor' ], 1 )
--            draw.SimpleText( '>> ' .. fus.config.npc[ 'overheadText' ] .. ' <<', 'fus_font_130', 0, 0, fus.config.npc[ 'overheadTextColor' ], 1 )
      cam.End3D2D()

end
