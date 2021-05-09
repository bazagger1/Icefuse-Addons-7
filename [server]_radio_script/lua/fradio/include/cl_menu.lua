--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_radio_script/lua/fradio/include/cl_menu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]



local __identifier = 'fradio'

local input_GetKeyName = input.GetKeyName

--------------------------------------------------------------------------------

-- Enable radio key bindings
local convar_enableKey1 = CreateClientConVar('fradio.enable_key1', KEY_LALT, true, false)
local convar_enableKey2 = CreateClientConVar('fradio.enable_key2', KEY_Z, true, false)

-- Mute radio key bindings
local convar_muteKey1 = CreateClientConVar('fradio.mute_key1', KEY_Z, true, false)
local convar_muteKey2 = CreateClientConVar('fradio.mute_key2', KEY_NONE, true, false)

--------------------------------------------------

--[[
-
]]
local function registerKeyBindings()

	FRadio.registerKeyBinding('enable', {
		keys = { convar_enableKey1:GetInt(), convar_enableKey2:GetInt() },
		onPressed = function()
			FRadio.changeClientEnabled(not FRadio.isPlayerEnabled(LocalPlayer()))
		end
	})

	FRadio.registerKeyBinding('mute', {
		keys = { convar_muteKey1:GetInt(), convar_muteKey2:GetInt() },
		onPressed = function()
			FRadio.changeClientMuted(not FRadio.isPlayerMuted(LocalPlayer()))
		end
	})

end
registerKeyBindings()

--------------------------------------------------

--[[
- @var panel
]]
FRadio._menuPanel = FRadio._menuPanel or nil

--[[
- @var table
]]
FRadio._menuOptions = FRadio._menuOptions or nil

--[[ ]]
function FRadio.toggleMenu()
	if IsValid(FRadio._menuPanel) then
		FRadio.closeMenu()
	else
		FRadio.openMenu()
	end
end

--[[ ]]
function FRadio.isMenuOpen()
	return IsValid(FRadio._menuPanel)
end

--[[ ]]
function FRadio.openMenu()
	FRadio.closeMenu()
	FRadio._menuPanel, FRadio._menuOptions = FRadio.createMenu()
end

--[[ ]]
function FRadio.closeMenu()
	if IsValid(FRadio._menuPanel) then
		FRadio._menuPanel:Remove()
		FRadio._menuPanel = nil
		FRadio._menuOptions = nil
	end
end

--[[
- @return panel|nil
]]
function FRadio.getMenuPanel()
	return FRadio._menuPanel
end

--[[
- @return table|nil
]]
function FRadio.getMenuOptions()
	return FRadio._menuOptions
end

--[[
- @return panel
]]
function FRadio.createMenu()

	local options = {}

	-- Frame
	local createFrame = function()

		local frame = vgui.Create('DFrame')
		frame:SetSize(300, 230)
		frame:Center()
		frame:MakePopup()
		frame:SetKeyboardInputEnabled(true)
		frame:SetMouseInputEnabled(true)
		frame:SetTitle("Frequency Radio")

		-- Make sure these hooks do get removed
		frame.OnClose = function()
			hook.Remove('PlayerButtonDown', __identifier..'.menu.keyChoose')
			hook.Remove('PlayerButtonUp', __identifier..'.menu.keyChoose')
		end
		frame.OnRemove = function()
			hook.Remove('PlayerButtonDown', __identifier..'.menu.keyChoose')
			hook.Remove('PlayerButtonUp', __identifier..'.menu.keyChoose')
		end

		return frame
	end

	-- Sheet container
	local createSheetContainer = function(parentPanel)

	    local propertySheet = vgui.Create('DPropertySheet', parentPanel)
	    propertySheet:SetPos(0 + 4, 24 + 4)
	    propertySheet:SetSize(parentPanel:GetWide() - 8, parentPanel:GetTall() - 24 - 8)

		return propertySheet
	end

	-- Sheet
	local createSheet = function(sheetContainer, name, icon, tooltip)

		local panel = vgui.Create('DPanel', sheetContainer)
		panel:SetPos(0, 0)
		panel:SetWide(sheetContainer:GetWide() - sheetContainer:GetPadding() * 2)
		panel:SetTall(sheetContainer:GetTall())
		panel.Paint = function() end

		local sheet = sheetContainer:AddSheet(name, panel, icon, false, false, tooltip)

		return panel, sheet
	end

	-- General panel
	local createGeneralPanel = function(parentPanel)

		local container = vgui.Create('DPanel', parentPanel)
		container:SetPos(0, 0)
		container:SetSize(parentPanel:GetSize())
		container.Paint = function() end

		local x, y = 0, 0

		do

			local getButtonKeyBindText = function(key1, key2)

				if key1 == 0 and key2 == 0 then
					return "No key bound"
				end

				return string.upper(input.GetKeyName(key1) .. (key2 ~= 0 and " + " .. input.GetKeyName(key2) or ""))
			end

			local doButtonKeyBind = function(button, finishCallback)
				local key1, key2 = 0, 0
				local keysPressed = {}

				button._OnMousePressed = button.OnMousePressed
				button._OnMouseReleased = button.OnMouseReleased

				button:SetText("")
				button.PaintOver = function(_, w, h)
					surface.SetDrawColor(255, 255, 0)
					surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
					surface.DrawOutlinedRect(0, 0, w, h)
				end

				-- options.frame:SetKeyboardInputEnabled(false)

				local finish = function()

					options.frame.OnKeyCodePressed = nil
					button.OnMousePressed = button._OnMousePressed
					options.frame.OnKeyCodeReleased = nil
					button.OnMouseReleased = button._OnMouseReleased

					-- options.frame:SetKeyboardInputEnabled(true)
					
					button.PaintOver = function() end

					finishCallback(key1, key2)

				end

				--[[
				-
				]]
				local onPressed = function(_, keyCode)

					if keyCode == KEY_BACKSPACE or keyCode == KEY_ENTER or keyCode == KEY_PAD_ENTER then
						finish()

						return
					end

					keysPressed[keyCode] = true

					if key1 == 0 then
						key1 = keyCode
					elseif key2 == 0 and keyCode ~= key1 then
						key2 = keyCode
					end

					button:SetText(getButtonKeyBindText(key1, key2))

				end
				options.frame.OnKeyCodePressed = onPressed
				button.OnMousePressed = onPressed

				--[[
				-
				]]
				local onReleased = function(_, keyCode)

					if nil == keysPressed[keyCode] then
						return
					end

					finish()

				end
				options.frame.OnKeyCodeReleased = onReleased
				button.OnMouseReleased = onReleased

			end

			-- Disable radio checkbox
			do
				x, y = x + 0, y + 0

				local checkbox = vgui.Create('DCheckBox', container)
				checkbox:SetPos(x + 0, y + 2)

				options.updateEnabledCheckbox = function()
					checkbox.OnChange = function() end
					checkbox:SetValue(FRadio.isPlayerEnabled(LocalPlayer()))
					checkbox.OnChange = function(pnl, value)
						FRadio.changeClientEnabled(value)
					end
				end
				options.updateEnabledCheckbox()

				local label = vgui.Create('DButton', container)
				label:SetPos(x + 22, y + 0)
				label:SetText("Disable radio")
				label:SizeToContentsX()
				label:SetTextColor(Color(240, 240, 240))
				label.Paint = function(pnl, w, h) end
				label.DoClick = function(pnl)
					checkbox:Toggle()
				end

		        local button = vgui.Create('DButton', container)
		        button:SetPos(container:GetWide() - 120, y)
		        button:SetSize(120, 22)
				button:SetText(getButtonKeyBindText(convar_enableKey1:GetInt(), convar_enableKey2:GetInt()))

				-- Key bind functionallity
				button.DoClick = function(pnl)
					doButtonKeyBind(button, function(key1, key2)

						convar_enableKey1:SetInt(key1)
						convar_enableKey2:SetInt(key2)

						registerKeyBindings()

					end)
				end

			end

		    -- Mute microphone checkbox
		    do
		        x, y = x + 0, y + 24

		        local checkbox = vgui.Create('DCheckBox', container)
		        checkbox:SetPos(x + 0, y + 2)

				options.updateMutedCheckbox = function()
					checkbox.OnChange = function() end
					checkbox:SetValue(FRadio.isPlayerMuted(LocalPlayer()))
					checkbox.OnChange = function(pnl, value)
						FRadio.changeClientMuted(value)
					end
				end
				options.updateMutedCheckbox()

		        local label = vgui.Create('DButton', container)
		        label:SetPos(x + 22, y + 0)
		        label:SetText("Mute radio")
		        label:SizeToContentsX()
		        label:SetTextColor(Color(240, 240, 240))
		        label.Paint = function(pnl, w, h) end
		        label.DoClick = function(pnl)
		            checkbox:Toggle()
		        end

		        local button = vgui.Create('DButton', container)
		        button:SetPos(container:GetWide() - 120, y)
		        button:SetSize(120, 22)
				button:SetText(getButtonKeyBindText(convar_muteKey1:GetInt(), convar_muteKey2:GetInt()))

				-- Key bind functionallity
				button.DoClick = function(pnl)
					doButtonKeyBind(button, function(key1, key2)

						convar_muteKey1:SetInt(key1)
						convar_muteKey2:SetInt(key2)

						registerKeyBindings()

					end)
				end

			end

		end

		x, y = x + 0, y + 32

	    -- Line
	    local splitter = vgui.Create('DPanel', container)
	    splitter:SetPos(x, y)
	    splitter:SetSize(container:GetWide(), 2)
	    splitter.Paint = function(pnl, w, h)
	        surface.SetDrawColor(120, 120, 120)
	        surface.DrawRect(0, 0, w, 1)
	        surface.SetDrawColor(160, 160, 160)
	        surface.DrawRect(0, 1, w, 1)
	    end

		do

			local x, y = x + 0, y + 10

			local rendered = false
			local frequencyLabel
			local frequencySlider1, frequencyNum1
			local frequencySlider2, frequencyNum2
			options.renderFrequency = function()

				if rendered == false then
					rendered = true

				    local label = vgui.Create('DLabel', container)
				    label:SetPos(x, y)
				    label:SetSize(container:GetWide(), 16)
				    label:SetText("Frequency")
				    label:SetTextColor(Color(200, 200, 200))
				    label:SetContentAlignment(5)

					x, y = x + 0, y + 20

				    local label = vgui.Create('DLabel', container)
				    label:SetPos(x, y)
				    label:SetSize(container:GetWide(), 16)
				    label:SetText("999.999 mHz")
				    label:SetTextColor(Color(240, 240, 240))
				    label:SetContentAlignment(5)
					frequencyLabel = label

					x, y = x + 0, y + 20
					do


				        local slider = vgui.Create('DNumSlider', container)
						frequencySlider1 = slider

				        slider:SetPos(x, y)
				        slider:SetSize(container:GetWide(), 24)
				        slider:SetMinMax(0, 999)
				        slider:SetDecimals(0)
						slider:SetDark(true)
				        slider:GetTextArea():SetWide(40)
				        slider.Label:SetVisible(false)

					end

					x, y = x + 0, y + 30
					do

				        local slider = vgui.Create('DNumSlider', container)
						frequencySlider2 = slider

				        slider:SetPos(x, y)
				        slider:SetSize(container:GetWide(), 24)
				        slider:SetMinMax(0, 999)
				        slider:SetDecimals(0)
				        slider:GetTextArea():SetWide(40)
				        slider.Label:SetVisible(false)

					end

				end

				local frequency = FRadio.getPlayerFrequency(LocalPlayer())

				frequencyLabel:SetText(FRadio.niceFormatFrequency(frequency).." mHz")

				-- So OnValueChanged is not called
				frequencySlider1.OnValueChanged = function() end
				frequencySlider2.OnValueChanged = function() end

				frequencySlider1:SetValue(frequency > 0 and math.floor(frequency / 1000) or 0)
				frequencySlider2:SetValue(frequency > 0 and math.floor(frequency % 1000) or 0)

				local function updatePlayerFrequency()
					local frequency = math.floor(frequencySlider1:GetValue()) * 1000 + math.floor(frequencySlider2:GetValue())
					if frequency ~= FRadio.getPlayerFrequency(LocalPlayer()) then
						frequencyLabel:SetText(FRadio.niceFormatFrequency(frequency).." mHz")

						FRadio.changeClientFrequencyLocally(frequency)
						timer.Create(__identifier..'.menu.frequencyUpdate', .5, 1, function()
							FRadio.changeClientFrequency(FRadio.getPlayerFrequency(LocalPlayer()))
						end)

					end
				end

				frequencySlider1.OnValueChanged = function(pnl, value)
					updatePlayerFrequency()
				end
				frequencySlider2.OnValueChanged = function(pnl, value)
					updatePlayerFrequency()
				end

			end
			options.renderFrequency()

		end

	end

	-- Channels panel
	local createChannelsPanel = function(parentPanel)

		local container = vgui.Create('DScrollPanel', parentPanel)
		container:SetPos(0, 0)
		container:SetSize(parentPanel:GetWide(), parentPanel:GetTall() - 36)

		options.renderChannels = function()
			container:Clear()

			local categoryY = 0
			for _, category in pairs(FRadio.getClientChannels()) do

                if table.Count(category.channels or {}) == 0 then
                    return
                end

				local categoryPanel = vgui.Create('DPanel', container)
				categoryPanel:SetPos(0, categoryY)
				categoryPanel:SetWide(container:GetWide())
				categoryPanel.Paint = function() end

				local label = vgui.Create('DLabel', categoryPanel)
				label:SetPos(2, 0)
				label:SetTall(20)
				label:SetText(category.name)
				label:SetColor(Color(240, 240, 240))
				label:SizeToContentsX()

			    -- Line
			    local splitter = vgui.Create('DPanel', categoryPanel)
			    splitter:SetPos(0, 20)
			    splitter:SetSize(categoryPanel:GetWide(), 2)
			    splitter.Paint = function(pnl, w, h)
			        surface.SetDrawColor(120, 120, 120)
			        surface.DrawRect(0, 0, w, 1)
			        surface.SetDrawColor(160, 160, 160)
			        surface.DrawRect(0, 1, w, 1)
			    end

				local label = vgui.Create('DLabel', categoryPanel)
				label:SetPos(2, 22)
				label:SetTall(20)
				label:SetText("Channel")
				label:SetColor(Color(180, 180, 180))
				label:SizeToContentsX()

				local label = vgui.Create('DLabel', categoryPanel)
				label:SetPos(82, 22)
				label:SetTall(20)
				label:SetText("Frequency")
				label:SetColor(Color(180, 180, 180))
				label:SizeToContentsX()

				local channelY = 42
				for _, channel in pairs(category.channels or {}) do

					local channelPanel = vgui.Create('DPanel', categoryPanel)
					channelPanel:SetPos(0, channelY)
					channelPanel:SetWide(categoryPanel:GetWide())
					channelPanel.Paint = function(pnl, w, h) end

					local label = vgui.Create('DLabel', channelPanel)
					label:SetPos(2, 2)
					label:SetTall(16)
					label:SetText(channel.name or "Unknown")
					label:SetColor(Color(200, 200, 200))
					label:SizeToContentsX()

					local label = vgui.Create('DLabel', channelPanel)
					label:SetPos(82, 2)
					label:SetTall(16)
					label:SetText(FRadio.niceFormatFrequency(channel.frequency or -1).." mHz")
					label:SetColor(Color(200, 200, 200))
					label:SizeToContentsX()

					local button = vgui.Create('DButton', channelPanel)
					button:SetPos(channelPanel:GetWide() - 60, 0)
					button:SetSize(40, 18)
					button:SetText("Join")
					button.DoClick = function(pnl)
						FRadio.changeClientFrequency(channel.frequency)
					end
					if FRadio.getPlayerFrequency(LocalPlayer()) == channel.frequency then
						button:SetDisabled(true)
					end

					channelPanel:SizeToChildren(false, true)
					channelY = channelY + channelPanel:GetTall() + 2

				end

				categoryPanel:SizeToChildren(false, true)
				categoryY = categoryY + categoryPanel:GetTall() + 8

			end


		end
		options.renderChannels()

	end

	-- Info panel
	local createInfoPanel = function(parentPanel)

		local container = vgui.Create('DScrollPanel', parentPanel)
		container:SetPos(0, 0)
		container:SetSize(parentPanel:GetWide(), parentPanel:GetTall() - 36)

		local label = vgui.Create('DLabel', container)
		label:SetWide(container:GetWide())
		label:SetWrap(true)
		label:SetAutoStretchVertical(true)

		label:SetTextColor(Color(240, 240, 240))
		label:SetText([[
		This radio is a frequency based radio, which means that you can talk to anyone that is on the same frequency.

		In order to talk over a frequency you must:
		- Enable your radio (See General tab)
		- Unmute the radio (See General tab)
		- Press your microphone button
		]])

	end

	----------------------------------------------------------------------------

	local frame = createFrame()
	options.frame = frame

	local sheetContainer = createSheetContainer(frame)
	local generalSheet = createSheet(sheetContainer, "General", 'icon16/wrench.png')
	local channelsSheet = createSheet(sheetContainer, "Channels", 'icon16/phone_sound.png')
	local infoSheet = createSheet(sheetContainer, "Info / Help", 'icon16/information.png')

	createGeneralPanel(generalSheet)
	createChannelsPanel(channelsSheet)
	createInfoPanel(infoSheet)

	return frame, options

end
