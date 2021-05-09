--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_radio_script/lua/fradio/include/sh_radio.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]



local playerMeta = FindMetaTable('Player')

local __identifier = 'fradio'

local string_sub = string.sub

--------------------------------------------------------------------------------

-- Utility functions
--------------------------------------------------------------------------------

--[[
- @arg string message
- @arg table format=nil
]]
function FRadio.error(message, format)
    error("]][FRadio] "..message:format(format))
end

--[[
- @arg string message
- @arg table format=nil
]]
function FRadio.errorNoHalt(message, format)
    ErrorNoHalt("[FRadio] "..message)
end

--[[
- @arg number frequency
- @return number
]]
function FRadio.validateFrequency(frequency)
    return frequency < 0 and 0 or frequency > 999999 and 999999 or frequency
end

--[[
- Niceify the frequency number
- @arg number frequency
- @return string
]]
function FRadio.niceFormatFrequency(frequency)

    if frequency == -1 then
        return '---.---'
    end

    frequency = frequency + 1000000
    return string_sub(frequency, 2, 4)..'.'..string_sub(frequency, 5, 7)
end

--
--------------------------------------------------------------------------------

--[[
- @private
- Set a player's frequency
- @arg player ply
- @arg number frequency
- @arg boolean validate=true - Whether to validate the frequency
]]
function FRadio._setPlayerFrequency(ply, frequency, validate)
    validate = validate == nil and true or validate

    ply.fradio.frequency
        = validate == true and FRadio.validateFrequency(frequency)
        or frequency

end

--[[
- Get a player's frequency
- @arg player ply
- @arg boolean niceFormat=false - Whether to return the frequency nice formatted
- @return number|string
]]
function FRadio.getPlayerFrequency(ply, niceFormat)
    niceFormat = validate == nil and false or niceFormat

    return niceFormat and FRadio.niceFormatFrequency(ply.fradio.frequency)
        or ply.fradio.frequency
end

--[[
- @private
- Set whether a player's radio is turned on
- @arg player ply
- @arg boolean isSpeaking
]]
function FRadio._setPlayerEnabled(ply, isMuted)
    ply.fradio.enabled = isMuted
end

--[[
- Whether a player's radio is turned on
- @arg player ply
- @return boolean
]]
function FRadio.isPlayerEnabled(ply)
    return ply.fradio.enabled == true
end

--[[
- @private
- Set whether a player's radio is muted
- @arg player ply
- @arg boolean isMuted
]]
function FRadio._setPlayerMuted(ply, isMuted)
    ply.fradio.muted = isMuted
end

--[[
- Whether a player has muted himself
- @arg player ply
- @return boolean
]]
function FRadio.isPlayerMuted(ply)
    return ply.fradio.muted == true
end

--[[
- Whether a player has a radio
- @return boolean
]]
function FRadio.hasPlayerRadio(ply)
    return ply:HasWeapon('ifn_fradio')
end

-- Player meta
--------------------------------------------------------------------------------

--[[
- Whether a player is initialized or not
- @arg player self
- @return boolean
]]
function playerMeta:isFRadioInitialized()
    return self.fradio ~= nil
end

--[[
- Get a player's frequency
- @arg player self
- @arg boolean niceFormat=false - Whether to return the frequency nice formatted
- @return number|string
]]
function playerMeta:getFRadioFrequency(niceFormat)
    return FRadio.getPlayerFrequency(self, niceFormat)
end

--[[
- Whether a player's radio is turned on
- @arg player self
- @return boolean
]]
function playerMeta:isFRadioEnabled()
    return FRadio.isPlayerRadioEnabled(self)
end

--[[
- Whether a player has muted himself
- @arg player self
- @return boolean
]]
function playerMeta:isFRadioMuted()
    return FRadio.isPlayerRadioMuted(self)
end
