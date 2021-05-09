--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_steam_group_rewards/lua/realgroup/cl_realgroup.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--
-- Menu created by Author. (http://steamcommunity.com/profiles/76561198076402038)
--

local blur = Material 'pp/blurscreen'
local function blurpanel(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat('$blur', (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
	end
end
local color_bg = Color(0,0,0,120)

surface.CreateFont('realGroupFont14', {font = 'roboto', size = 14, weight = 400})
surface.CreateFont('realGroupFont18', {font = 'roboto', size = 18, weight = 400})
surface.CreateFont('realGroupFont24', {font = 'roboto', size = 24, weight = 400})


local function menu()
    local panel = vgui.Create("DPanel")
    panel:SetSize(400, 264)
    panel:Center()
    panel:MakePopup()
--    table.insert(MatUI.ClickExit, panel)

    function panel.Paint(s, w, h)

        blurpanel(s)
		surface.SetDrawColor(color_bg)
		-- surface.DrawRect(0, 0, w, 25)
		surface.DrawRect(0, 0, w, h)

        -- s:NoClipping(true)
        -- surface.SetDrawColor(255, 255, 255)
        -- surface.DrawRect(0, 0, w, h)
        --
        -- surface.SetDrawColor(225, 225, 225)
        -- surface.DrawRect(0, h-(36+16), w, (36+16))
        --
        -- surface.SetDrawColor(255, 255, 255)
        -- surface.DrawRect(0, 0, w, h-(36+16))
    end

     local text = vgui.Create("ExText", panel)
     text:Dock(FILL)
     text:DockMargin(16, 16, 16, 16)
     text:InvalidateParent(true)
     text:Open()
     text:AppendLine({
          Type = "Font",
          Data = "realGroupFont14",
     },
     {
          Type = "Color",
          Data = Color(220, 220, 220),
     },
     {
          Type = "Text",
          Data = RealGroup.Window.Body,
     })

    local title = vgui.Create("DPanel", panel)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, 0)
    title.text = RealGroup.Window.Title
    surface.SetFont("Roboto Bold")
    title.textw, title.texth = surface.GetTextSize(title.text)
    title:SetTall(20 + title.texth)

    function title.Paint(s, w, h)
        surface.SetDrawColor(0, 0, 0, 120)
        surface.DrawRect(0, 0, w, h)
        surface.SetFont("realGroupFont18")
        surface.SetTextColor(Color(255, 255, 255))
        surface.SetTextPos(16, (h / 2 - s.texth / 2) - 2)
        surface.DrawText(s.text)
    end

     local footer = vgui.Create("DPanel", panel)
     footer:Dock(BOTTOM)
     footer:InvalidateParent(true)
     footer:SetTall(36)
     footer:DockMargin(8, 8, 8, 8)
     footer.Paint=function(s, w, h) --surface.SetDrawColor(230, 230, 230) surface.DrawRect(0, 0, w, h)
     end

    local options = {
          {text = RealGroup.Window.Yes:upper(), col = {0, 200, 255}, func = function()
               net.Start("RealGroup:76561198257677408")
               net.SendToServer()
               gui.OpenURL("http://steamcommunity.com/groups/" .. RealGroup.GroupURLID)
               panel:Remove()
          end,},
          {text = RealGroup.Window.No:upper(), col = {255, 100, 100}, func = function()
               panel:Remove()
          end,},
     }

     for k, v in pairs(options) do
          local button = vgui.Create("DButton", footer)
          button:Dock(LEFT)
          button:DockMargin(0, 0, 8, 0)
          button:InvalidateParent(true)
          button:SetText(v.text)
          button:SetFont("Roboto Medium")
          button.Color = v.col

          function button.CustomPaint(s, w, h)

              draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 180))

               surface.SetFont(s:GetFont())
               local textw, texth = surface.GetTextSize(s:GetText())
               local _w = textw+32

               if _w ~= s:GetWide() then
                    s:SetWide(_w > (64+16) and _w or (64+16))
               end
          end

          function button.Close(s)
               panel:Remove()
          end

          function button.CustomClick(s)
               if v.func then
                    v.func(s)
               end
          end

          FancyButton(button)
     end
end

local keys = {
     IN_FORWARD,
     IN_BACK,
     IN_LEFT,
     IN_RIGHT,
     IN_DUCK,
     IN_JUMP
}

net.Receive("RealGroup:76561198257677408",function()
     local a = net.ReadInt(8)
     if a == 2 then
          local s = net.ReadString()
          chat.AddText(color_white, "[", Color(0,175,255),RealGroup.Chat.Tag,Color(255,255,255),"] " .. s)
     end
     if a == 5 then
          menu()
     end
     if a == 3 then
          hook.Add("KeyRelease","RealGroup:76561198257677408",function(_,key)

			if table.HasValue(keys,key) then

				menu()

				hook.Remove("KeyRelease","RealGroup:76561198257677408")

			end

		end)
     end
end)
