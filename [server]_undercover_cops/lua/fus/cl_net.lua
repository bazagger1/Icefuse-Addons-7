--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_undercover_cops/lua/fus/cl_net.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

net.Receive( 'fus.notifyPlayer', function()

      local data = net.ReadTable()
      if not data then return end

      chat.AddText( Color(255, 30, 30), 'Icefuse Admin: ', color_white, unpack( data ) )

end )

net.Receive( 'fus.undercoverNotify', function()

      local isUndercover = net.ReadBool()

      if isUndercover then

            btn = vgui.Create( 'fus_DButton' )
            btn:SetSize( 100, 25 )
            btn:SetPos( ScrW() / 2 - 50, 15 ) --btn:SetPos( ScrW() / 2 - 50, 20 )

            btn.text = 'End now'

            function btn:DoClick()

                  net.Start( 'fus.quickEnd' )
                  net.SendToServer()

                  self:Remove()

            end

      else

            if IsValid( btn ) then
                  btn:Remove()
            end

      end

end )

net.Receive( 'fus.openAdminMenu', function()
      fus.adminMenu( net.ReadTable() or {} )
end )

net.Receive( 'fus.broadcastJobs', function()

      local data = net.ReadTable()
      if not data then return end

      fus.jobData = data

end )

net.Receive( 'fus.printUndercover', function()

      MsgC( Color( 25, 255, 25 ), '-------- LIST OF UNDERCOVER PLAYERS --------\n' )

      local players     = player.GetAll()
      local found       = false

      for i = 1, #players do

            local ply = players[ i ]

            if not ( ply and IsValid( ply ) ) then continue end
            if not ply:GetNWBool( 'isUndercover' ) then continue end

            found = true

            MsgC( Color( 25, 255, 25 ), ply:Name(), color_white, ' - Original job: ' .. ply:GetNWString( 'oldUndercoverTeam' ) .. ' - Undercover job: ' .. team.GetName( ply:Team() ) .. '\n' )

      end

      if not found then
            MsgC( Color( 255, 25, 25 ), 'NO PLAYERS ARE UNDERCOVER!\n' )
      end

      MsgC( Color( 25, 255, 25 ), '--------------------------------\n' )

end )

net.Receive( 'fus.printCommands', function()

      local data = net.ReadTable()
      if not data then return end

      MsgC( '----------- POLICE SYSTEM COMMANDS -----------\n' )

      for _, data in pairs( data ) do
            MsgC( data.description .. '\n\n' )
      end

      MsgC( '----------------------------------------------\n' )

end )
