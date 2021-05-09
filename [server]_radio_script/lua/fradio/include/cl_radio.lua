--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_radio_script/lua/fradio/include/cl_radio.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]



local playerMeta = FindMetaTable('Player')

local __identifier = FRadio.identifier

local __networkIdentifier = __identifier..'.network'

--------------------------------------------------------------------------------

--
--------------------------------------------------------------------------------

--[[
- @private
- Players that have yet to initialize
- @var table
]]
FRadio._playerInitBuffer = FRadio._playerInitBuffer or {}

--[[
- @private
- Cache for the client's frequency channels
- @var table
]]
FRadio._clientFrequencyChannelNameCache = FRadio._clientFrequencyChannelNameCache or {} -- Long name...

--[[
- Initializes a player.
-
- @arg player ply
]]
function FRadio.initializePlayer(ply)

    -- Ignore if player was already initialized
    if ply.fradio ~= nil then
        return
    end

    ply.fradio = {
        enabled = true,
        muted = true,
        channels = {},
        frequency = -1,
        frequencyHash = -1
    }

    -- Call waiting callbacks for player
    if ply == LocalPlayer() then
        if FRadio._playerInitBuffer['client'] then
            for _, callback in pairs(FRadio._playerInitBuffer['client']) do
                local noErrors, message = pcall(callback, ply)
                if noErrors == false then
                    FRadio.errorNoHalt(message)
                end
            end
            FRadio._playerInitBuffer['client'] = nil
        end
    end
    if FRadio._playerInitBuffer[ply:EntIndex()] then
        for _, callback in pairs(FRadio._playerInitBuffer[ply:EntIndex()]) do
            local noErrors, message = pcall(callback, ply)
            if noErrors == false then
                FRadio.errorNoHalt(message)
            end
        end
        FRadio._playerInitBuffer[ply:EntIndex()] = nil
    end

end

--[[
- Wait for a player to initialize
- @arg string|number ply
- @arg function callback
]]
function FRadio.waitForPlayer(index, callback)

    local ply = index == 'client' and LocalPlayer() or Entity(index)
    if IsValid(ply) then -- and ply:isFRadioInitialized() -- Assumne this has already happened
        callback(ply)
    else
        FRadio._playerInitBuffer[index] = FRadio._playerInitBuffer[index] or {}
        table.insert(FRadio._playerInitBuffer[index], callback)
    end

end

--[[
- @private
- Called whenever a player's frequency has been changed
-   NOTE: The client only knows its own frequency
- @arg player ply
- @arg number frequency
- @arg number prevFrequency - If frequency was set locally this will be the same value as frequency
]]
function FRadio._onPlayerFrequencyChanged(ply, frequency, prevFrequency)
    -- Nothing yet
end

--[[
- @private
- Called whenever a player's frequency hash has been changed
- @arg player ply
- @arg number frequencyHash
- @arg number prevFrequencyHash
]]
function FRadio._onPlayerFrequencyHashChanged(ply, frequencyHash, prevFrequencyHash)
    -- Nothing yet
end

--[[
- Change the client's frequency
- @arg number frequency
]]
function FRadio.changeClientFrequency(frequency)
    FRadio.networkClientFrequency(frequency)
end

--[[
- Change the client's frequency locally (will not be send to the server)
- @arg number frequency
]]
function FRadio.changeClientFrequencyLocally(frequency)
    FRadio._setPlayerFrequency(LocalPlayer(), frequency, true)
end

--[[
- Change whether the client has enabled its radio
- @arg boolean isEnabled
]]
function FRadio.changeClientEnabled(isEnabled)
    FRadio.networkClientEnabled(isEnabled)
end

--[[
- Change whether the client has muted its radio
- @arg boolean isMuted
]]
function FRadio.changeClientMuted(isMuted)
    FRadio.networkClientMuted(isMuted)
end

--[[
- @private
- Set a player's frequency hash
]]
function FRadio._setPlayerFrequencyHash(ply, frequencyHash)
    ply.fradio.frequencyHash = frequencyHash
end

--[[
- Get a player's frequency hash
]]
function FRadio.getPlayerFrequencyHash(ply)
    return ply.fradio.frequencyHash
end

--[[
- @private
- Set the client's channels
- @arg table channelCategories
]]
function FRadio._setClientChannels(channelCategories)

    for categoryIdentifier, category in pairs(channelCategories) do
        LocalPlayer().fradio.channels[categoryIdentifier] = category
    end

    -- Reprocess the cache
    FRadio._clientFrequencyChannelCache = {}
    for _, category in pairs(FRadio.getClientChannels()) do
        for _, channel in pairs(category.channels) do
            FRadio._clientFrequencyChannelNameCache[channel.frequency or -1] = channel.name or "UNKOWN"
        end
    end

end

--[[
- GetPadding the client's channels
- @return table
]]
function FRadio.getClientChannels()
    return LocalPlayer().fradio.channels
end

--[[
- Get client's know channel name for a frequency
- @return string|false
]]
function FRadio.getClientChannelNameForFrequency(frequency)
    return FRadio._clientFrequencyChannelNameCache[frequency] or false
end

-- Networking
--------------------------------------------------------------------------------

--[[
- Send the client's frequency to the server
]]
function FRadio.networkClientFrequency(frequency)

    net.Start(__networkIdentifier)
        net.WriteString('client.frequency')
        net.WriteTable({frequency})
    net.SendToServer()

end

--[[
- Send whether the client has enabled its radio
- @arg boolean isEnabled
]]
function FRadio.networkClientEnabled(isEnabled)

    net.Start(__networkIdentifier)
        net.WriteString('client.enabled')
        net.WriteTable({isEnabled})
    net.SendToServer()

end

--[[
- Set whether the client has muted its radio
- @arg boolean isMuted
]]
function FRadio.networkClientMuted(isMuted)

    net.Start(__networkIdentifier)
        net.WriteString('client.muted')
        net.WriteTable({isMuted})
    net.SendToServer()

end

-- Network receive handlers
local networkHandlers = {

    -- client.frequency
    ['client.frequency'] = function(frequency)
        FRadio.waitForPlayer('client', function(ply)

            local prevFrequency = FRadio.getPlayerFrequency(ply)
            FRadio._setPlayerFrequency(ply, frequency, false)
            FRadio._onPlayerFrequencyChanged(ply, frequency, prevFrequency)

            -- Update menu
            if FRadio.isMenuOpen() then
                FRadio.getMenuOptions().renderChannels()
                FRadio.getMenuOptions().renderFrequency()
            end

        end)
    end,

    -- player.frequency
    ['player.frequency'] = function(plyIndex, frequency)
        FRadio.waitForPlayer(plyIndex, function(ply)
            local prevFrequency = FRadio.getPlayerFrequency(ply)
            FRadio._setPlayerFrequency(ply, frequency, false)
            FRadio._onPlayerFrequencyChanged(ply, frequency, prevFrequency)
        end)
    end,

    -- player.frequencyHash
    ['player.frequencyHash'] = function(plyIndex, frequencyHash)
        FRadio.waitForPlayer(plyIndex, function(ply)
            local prevFrequencyHash = FRadio.getPlayerFrequencyHash(ply)
            FRadio._setPlayerFrequencyHash(ply, frequencyHash)
            FRadio._onPlayerFrequencyHashChanged(ply, frequencyHash, prevFrequencyHash)
        end)
    end,

    -- player.enabled
    ['player.enabled'] = function(plyIndex, isEnabled)
        FRadio.waitForPlayer(plyIndex, function(ply)
            FRadio._setPlayerEnabled(ply, isEnabled)

            -- Update menu
            if ply == LocalPlayer() and FRadio.isMenuOpen() then
                FRadio.getMenuOptions().updateEnabledCheckbox()
            end

        end)
    end,

    -- player.muted
    ['player.muted'] = function(plyIndex, isMuted)
        FRadio.waitForPlayer(plyIndex, function(ply)
            FRadio._setPlayerMuted(ply, isMuted)

            -- Update menu
            if ply == LocalPlayer() and FRadio.isMenuOpen() then
                FRadio.getMenuOptions().updateMutedCheckbox()
            end

        end)
    end,

    -- player.channels
    ['client.channels'] = function(channelCategories)
        FRadio.waitForPlayer('client', function(ply)
            FRadio._setClientChannels(channelCategories)

            -- Update menu
            if FRadio.isMenuOpen() then
                FRadio.getMenuOptions().renderChannels()
            end

        end)
    end

}
net.Receive(__networkIdentifier, function(len)
    local id, data = net.ReadString(), net.ReadTable()
    if networkHandlers[id] then
        networkHandlers[id](unpack(data))
    end
end)

-- Hooks
--------------------------------------------------------------------------------

--[[
- Called when an entity is created.
-
- @hook: OnEntityCreated
]]
hook.Add('OnEntityCreated', __identifier, function(ent)

    if not ent:IsPlayer() then
        return
    end

    -- Initialize the player
    FRadio.initializePlayer(ent)

end)

-- HUDPaint
hook.Add('HUDPaint', __identifier, function()

    if not FRadio.hasPlayerRadio(LocalPlayer()) then
        return
    end

    local y = 120

    if FRadio.isPlayerEnabled(LocalPlayer()) then

        y = y + 0
        draw.SimpleText("Radio is enabled <", 'HudHintTextLarge', ScrW() - 24, y, Color(0, 255, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

        y = y + 16
        if FRadio.isPlayerMuted(LocalPlayer()) then
            draw.SimpleText("Radio is muted <", 'HudHintTextLarge', ScrW() - 24 + 1, y, Color(255, 0, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        else
            draw.SimpleText("Radio is not muted <", 'HudHintTextLarge', ScrW() - 24 + 1, y, Color(0, 255, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        end

        local frequency = FRadio.getPlayerFrequency(LocalPlayer(), false)

        y = y + 16
        draw.SimpleText("Frequency "..FRadio.niceFormatFrequency(frequency).." mHz <", 'HudHintTextLarge', ScrW() - 24, y, Color(0, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

        local channelName = FRadio.getClientChannelNameForFrequency(frequency)
        if channelName ~= false then
            y = y + 16
            draw.SimpleText("Channel "..channelName.." <", 'HudHintTextLarge', ScrW() - 24 + 1, y, Color(0, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        end

    else
        draw.SimpleText("Radio is disabled <", 'HudHintTextLarge', ScrW() - 24, y, Color(255, 0, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    end

end)

hook.Add('PlayerStartVoice', __identifier, function(ply)
    if ply == LocalPlayer() then
        if FRadio.hasPlayerRadio(ply) == true and FRadio.isPlayerEnabled(ply) == true and FRadio.isPlayerMuted(ply) == false then
            ply:EmitSound('npc/overwatch/radiovoice/on1.wav', 40)
        end
    end
end)
hook.Add('PlayerEndVoice', __identifier, function(ply)
    if ply == LocalPlayer() then
        if FRadio.hasPlayerRadio(ply) == true and FRadio.isPlayerEnabled(ply) == true and FRadio.isPlayerMuted(ply) == false then
            ply:EmitSound('npc/overwatch/radiovoice/off4.wav', 45)
        end
    end
end)
