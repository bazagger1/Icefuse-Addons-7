--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_radio_script/lua/weapons/ifn_fradio/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include 'shared.lua'

local __identifier = 'fradio'

--------------------------------------------------------------------------------

util.PrecacheSound('ifn/fradio/noise.wav')

function SWEP:Initialize()

    self._nextPrimaryFire = 0
    self._nextPlayersOnFrequencyUpdate = 0
    self._playersOnFrequency = {}
    self.isSpeakingSoundActive = false

end

function SWEP:PrimaryAttack()

    if not FRadio.isMenuOpen() then
        FRadio.openMenu()
    end

end

function SWEP:SecondaryAttack()

    if not FRadio.isMenuOpen() then
        FRadio.openMenu()
    end

end

function SWEP:Think()

    -- Background noise when a player is talking over the radio
    do
        if self._nextPlayersOnFrequencyUpdate <= SysTime() then
            self._nextPlayersOnFrequencyUpdate = SysTime() + .1

            local localHash = FRadio.getPlayerFrequencyHash(LocalPlayer())

            self._playersOnFrequency = {}
            for _, ply in pairs(player.GetAll()) do
                if ply ~= LocalPlayer() and FRadio.getPlayerFrequencyHash(ply) == localHash then
                    table.insert(self._playersOnFrequency, ply)
                end
            end

        end

        if #self._playersOnFrequency == 0 then
            if self.isSpeakingSoundActive == true then
            self:StopSound('ifn/fradio/noise.wav')
            end
        else
            local isSomeoneSpeaking = false
            for _, ply in ipairs(self._playersOnFrequency) do
                if ply:VoiceVolume() > 0 then
                    isSomeoneSpeaking = true
                    break
                end
            end
            if isSomeoneSpeaking then
                if self.isSpeakingSoundActive == false then
                    self.isSpeakingSoundActive = true
                    -- self:EmitSound('ifn/fradio/noise.wav', 40)
                end
            else
                if self.isSpeakingSoundActive == true then
                    self.isSpeakingSoundActive = false
                    -- self:StopSound('ifn/fradio/noise.wav')
                end
            end
        end
    end

end

function SWEP:ViewModelDrawn()

    if IsValid(self.Owner) == false or self.Owner:isFRadioInitialized() == false then
        return
    end

    local radioPos, radioAng
    repeat

        local viewModel = self.Owner:GetViewModel()
        if not IsValid(viewModel) then
            break
        end

        local bone, boneMatrix = viewModel:LookupBone('radio'), nil
        if bone then
            boneMatrix = viewModel:GetBoneMatrix(bone)
        end

        if not boneMatrix then
            break
        end

        radioPos, radioAng = boneMatrix:GetTranslation(), boneMatrix:GetAngles()

    until true -- dem hacks

    if not radioPos then
        return
    end

    -- Draw
    do
        local pos, ang = Vector(radioPos), Angle(radioAng.p, radioAng.y, radioAng.r)

        ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), 180)
		ang:RotateAroundAxis(ang:Up(), -270)

        pos = pos + ang:Right() * -3.9 + ang:Forward() * -0.72 + ang:Up() * -0.275

        cam.Start3D2D(pos, ang, 0.023)
			draw.SimpleText(self.Owner:getFRadioFrequency(true).." mHz", 'default', 0, 0, Color(5, 5, 5, 200))
		cam.End3D2D()

    end

end

--[[
function SWEP:ViewModelDrawn()

    if IsValid(self.Owner) == false or self.Owner:isFRadioInitialized() == false then
        return
    end

    local radioPos, radioAng
    repeat

        local viewModel = self.Owner:GetViewModel()
        if not IsValid(viewModel) then
            break
        end

        local bone, boneMatrix = viewModel:LookupBone('radio'), nil
        if bone then
            boneMatrix = viewModel:GetBoneMatrix(bone)
        end

        if not boneMatrix then
            break
        end

        radioPos, radioAng = boneMatrix:GetTranslation(), boneMatrix:GetAngles()

    until true -- dem hacks

    if not radioPos then
        return
    end

    -- Draw
    do
        local pos, ang = Vector(radioPos), Angle(radioAng.p, radioAng.y, radioAng.r)

        local textColor = Color(5, 5, 5, 200)
        do

            local screenPos = (radioPos + ang:Right() * .25 + ang:Forward() * 3.6 + ang:Up() * 0):ToScreen()

            render.CapturePixels()
            local pR, pG, pB = render.ReadPixel(screenPos.x, screenPos.y)
            if pR + pG + pB < 112 then
                textColor = Color(70, 180, 95, 80)
            end

        end

        ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), 180)
		ang:RotateAroundAxis(ang:Up(), -270)

        pos = pos + ang:Right() * 3.85 + ang:Forward() * -7.90 + ang:Up() * -0.28

        cam.Start3D2D(pos, ang, 0.03)
			draw.SimpleText(self.Owner:getFRadioFrequency(true), 'default', 240, -260, textColor)
			draw.SimpleText(self.Owner:isFRadioSpeaking() and '!' or '', 'default', 281, -260, textColor)
		cam.End3D2D()

    end

    do
        -- local pos, ang = Vector(radioPos), Angle(radioAng.p, radioAng.y, radioAng.r)
        --
        -- pos = pos + ang:Right() * 3.85 + ang:Forward() * -7.90 + ang:Up() * -0.28
        --
        -- render.DrawLine(pos, pos + 8 * ang:Forward(), Color( 255, 0, 0 ), true )
        -- render.DrawLine(pos, pos + 8 * -ang:Right(), Color( 0, 255, 0 ), true )
        -- render.DrawLine(pos, pos + 8 * ang:Up(), Color( 0, 0, 255 ), true )

    end

    -- Calculate the button positions of the model
    if not self.buttonRecalculateTime or self.buttonRecalculateTime <= SysTime() then
        self.buttonRecalculateTime = SysTime() + .1

        local pos, ang = Vector(radioPos), Angle(radioAng.p, radioAng.y, radioAng.r)

        self.b1Pos = nil

        local screen1 = (pos + ang:Right() * .8 + ang:Forward() * 5.2 + ang:Up() * -0.2):ToScreen()
        local screen2 = (pos + ang:Right() * .8 + ang:Forward() * 4.4 + ang:Up() * .4):ToScreen()
        self.b2Pos = {
            {x = math.floor(screen1.x), y = math.ceil(screen1.y)},
            {x = math.floor(screen2.x), y = math.ceil(screen2.y)}
        }

        local screen1 = (pos + ang:Right() * .8 + ang:Forward() * 5.2 + ang:Up() * .55):ToScreen()
        local screen2 = (pos + ang:Right() * .8 + ang:Forward() * 4.4 + ang:Up() * 1.2):ToScreen()
        self.b3Pos = {
            {x = math.floor(screen1.x), y = math.ceil(screen1.y)},
            {x = math.floor(screen2.x), y = math.ceil(screen2.y)}
        }

        -- self.b1Pos = {{x = 0, y = 0}, {x = 0, y = 0}}
        -- self.b2Pos = {{x = 0, y = 0}, {x = 0, y = 0}}
        -- self.b3Pos = {{x = 0, y = 0}, {x = 0, y = 0}}

    end

end

function SWEP:Think()

    if IsValid(self.Owner) == false or self.Owner:isFRadioInitialized() == false then
        return
    end

    if input.IsMouseDown(MOUSE_MIDDLE) then
        if not self.isSpeaking then
            self.isSpeaking = true
            FRadio.beginSpeaking()
        end
    else
        if self.isSpeaking == true then
            self.isSpeaking = false
            FRadio.endSpeaking()
        end
    end

    if self.updateFrequencyTime and self.updateFrequencyTime <= SysTime() then
        self.updateFrequencyTime = false

        -- Change the client frequency
        FRadio.changeClientFrequency(LocalPlayer():getFRadioFrequency())

    end

    if input.IsMouseDown(MOUSE_RIGHT) then
        self.wasMouseEnabled = true
        gui.EnableScreenClicker(true)
    elseif self.wasMouseEnabled then
        self.wasMouseEnabled = false
        gui.EnableScreenClicker(false)
    end

    if input.IsMouseDown(MOUSE_RIGHT) then

        local mouseX, mouseY = gui.MousePos()

        if self.selectedButton and input.IsMouseDown(MOUSE_LEFT) then
            gui.SetMousePos(self.selectedMousePosition.x, self.selectedMousePosition.y)

            local currentFrequency = LocalPlayer():getFRadioFrequency()
            local addFrequency = mouseX - self.selectedMousePosition.x

            if self.selectedButton == 2 then
                FRadio.changeClientFrequencyLocally(currentFrequency + (addFrequency * 1000))
            elseif self.selectedButton == 3 then
                FRadio.changeClientFrequencyLocally(currentFrequency + (addFrequency * 1))
            end

            if addFrequency ~= 0 then
                self.updateFrequencyTime = SysTime() + .5
            end

        else
            if self.selectedButton then
                self.selectedButton = nil
                gui.SetMousePos(self.selectedMousePosition.x, self.selectedMousePosition.y)
            else
                if self.b2Pos and self.b2Pos[1].x < mouseX and self.b2Pos[2].x > mouseX and self.b2Pos[1].y < mouseY and self.b2Pos[2].y > mouseY then
                    if input.IsMouseDown(MOUSE_LEFT) then
                        self.selectedButton = 2
                        self.selectedMousePosition = {x = mouseX, y = mouseY}
                    end
                elseif self.b3Pos and self.b3Pos[1].x < mouseX and self.b3Pos[2].x > mouseX and self.b3Pos[1].y < mouseY and self.b3Pos[2].y > mouseY then
                    if input.IsMouseDown(MOUSE_LEFT) then
                        self.selectedButton = 3
                        self.selectedMousePosition = {x = mouseX, y = mouseY}
                    end
                end
            end
        end

    end

end
]]
