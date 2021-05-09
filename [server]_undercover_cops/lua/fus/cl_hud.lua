--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_undercover_cops/lua/fus/cl_hud.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local btn

function fus.hud()

      local ply = LocalPlayer()

      if ply:GetNWBool( 'isUndercover' ) then

            local timeLeft          = ply:GetNWInt( 'undercoverEnd' ) - CurTime()
            local mainBarW          = 300
            local barW              = mainBarW * timeLeft / fus.config.undercover[ 'undercoverTime' ]
            local barH              = 20

            fus.drawBox( ScrW() / 2 - ( mainBarW / 2 ), 40, mainBarW, barH ) --fus.drawBox( ScrW() / 2 - ( mainBarW / 2 ), 0, mainBarW, barH )
            fus.drawBox( ScrW() / 2 - ( mainBarW / 2 ), 40, barW, barH, fus.clientVal( 'undercoverBarColor' ) ) --fus.drawBox( ScrW() / 2 - ( mainBarW / 2 ), 0, barW, barH, fus.clientVal( 'undercoverBarColor' ) )

            fus.txt( 'Undercover as: ' .. LocalPlayer():getDarkRPVar( 'job' ), 15, ScrW() / 2, 50, nil, 1, 1 ) --fus.txt( 'Undercover: ' .. LocalPlayer():getDarkRPVar( 'job' ), 15, ScrW() / 2, 10, nil, 1, 1 )

      end

end

hook.Add( 'HUDPaint', 'fus.hud', fus.hud )
