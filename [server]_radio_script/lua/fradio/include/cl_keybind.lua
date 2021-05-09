--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_radio_script/lua/fradio/include/cl_keybind.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local IsFirstTimePredicted = IsFirstTimePredicted

--------------------------------------------------

local bindings = {}
local rootSequence = { children = {} }

--[[
- @param string name
- @param table options
]]
function FRadio.registerKeyBinding(name, options)

    if bindings[name] then
        FRadio.removeKeyBinding(name)
    end

    local keyCodes = options.keys
    if #keyCodes == 0 then
        error("Key binding requires at least 1 key.")
    end

    -- Make key sequence
    local sequence = rootSequence
    for i, keyCode in ipairs(keyCodes) do

        if keyCode <= 0 then
            continue
        end

        if sequence.children[keyCode] == nil then
            sequence.children[keyCode] = {
                parent = sequence,
                children = {},
                bindings = {}
            }
        end
        sequence = sequence.children[keyCode]

    end

    -- Ignore when the keyCodes were all <= 0
    if sequence == rootSequence then
        return
    end

    -- Put the binding in the inner sequence key
    table.insert(sequence.bindings, name)
    bindings[name] = options

end

--[[
- @param string name
]]
function FRadio.removeKeyBinding(name)

    if bindings[name] == nil then
        return
    end

    local options = bindings[name]

    local sequence = rootSequence
    for _, keyCode in ipairs(options.keys) do

        if keyCode <= 0 then
            continue
        end

        sequence = sequence.children[keyCode]

    end

    -- Remove it ...
    table.RemoveByValue(sequence.bindings, name)
    bindings[name] = nil

    -- Now in reverse clear up the empty tables
    while true do

        if sequence == rootSequence then
            break
        end

        -- If there's children or bindings the table is not empty..
        if not (0 == table.Count(sequence.children) and 0 == #sequence.bindings) then
            break
        end

        local parent = sequence.parent

        table.RemoveByValue(parent.children, sequence)
        sequence = parent

    end

end

--------------------------------------------------

local keysDown = {}
local keysDownChain = {}

local partOfSequence = {}

--[[
- @hook PlayerButtonDown
]]
hook.Add('PlayerButtonDown', 'fradio.keybind', function(ply, keyCode)

    -- Ignore if this call is predicted
	if not IsFirstTimePredicted() then
		return
	end

	if keysDown[keyCode] then -- Should not be possible..?
		return
	end

    -- Keep track of the pressed key
	keysDown[keyCode] = true
	table.insert(keysDownChain, keyCode)

    -- Find the active bindings
    local sequence = rootSequence
    for _, key in ipairs(keysDownChain) do

        -- Ignore if the pressed key is not part of this sequence
        if nil == sequence.children[key] then
            continue
        end

        -- The key is part of a binding sequence...
        partOfSequence[key] = true

        -- Move in to the sequence
        sequence = sequence.children[key]

        -- The bindings within this sequence only pressed if the key was actually pressed this time
        if key == keyCode then
            for _, name in ipairs(sequence.bindings) do
                local options = bindings[name]

                if options.onPressed then
                    options.onPressed()
                end

            end
        end

    end

end)

--[[
- @hook PlayerButtonDown
]]
hook.Add('PlayerButtonUp', 'fradio.keybind', function(ply, keyCode)

    -- Ignore if this call is predicted
	if not IsFirstTimePredicted() then
		return
	end

	if not keysDown[keyCode] then -- Should not be possible..?
		return
	end

    -- Remove this key from the chain
	local index = table.RemoveByValue(keysDownChain, keyCode)
    keysDown[keyCode] = nil

    if index == false then
        return
    end

    if partOfSequence[keyCode] == true then
        partOfSequence[keyCode] = nil

        -- Remove all pressed keys from the chain that were pressed ofter this one
        while index <= #keysDownChain do
            keysDownChain[index] = nil
            index = index + 1
        end

    end

end)
