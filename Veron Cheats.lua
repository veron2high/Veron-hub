-- ================================================
--   VERON HUB v2.0 - Roblox Executor
--   UI: Dark Purple Neon | Tab System
--   Made by Veron
-- ================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Simpan lighting asli untuk restore
local originalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
}

-- ================================================
-- WARNA TEMA UNGU NEON
-- ================================================
local C = {
    bg        = Color3.fromRGB(10, 8, 20),
    bg2       = Color3.fromRGB(18, 14, 35),
    bg3       = Color3.fromRGB(26, 20, 50),
    neon      = Color3.fromRGB(168, 85, 247),
    neonDim   = Color3.fromRGB(88, 28, 135),
    neonGlow  = Color3.fromRGB(196, 132, 252),
    tabActive = Color3.fromRGB(88, 28, 135),
    tabOff    = Color3.fromRGB(18, 14, 35),
    text      = Color3.fromRGB(230, 220, 255),
    textDim   = Color3.fromRGB(120, 100, 160),
    toggleOn  = Color3.fromRGB(168, 85, 247),
    toggleOff = Color3.fromRGB(35, 28, 60),
    white     = Color3.fromRGB(255, 255, 255),
    green     = Color3.fromRGB(74, 222, 128),
    red       = Color3.fromRGB(248, 113, 113),
}

-- ================================================
-- CLEANUP LAMA
-- ================================================
if game.CoreGui:FindFirstChild("Veron") then
    game.CoreGui.Veron:Destroy()
end

-- ================================================
-- SCREEN GUI
-- ================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Veron"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- ================================================
-- OPEN BUTTON (muncul kalau GUI disembunyikan)
-- ================================================
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 110, 0, 32)
OpenBtn.Position = UDim2.new(0, 12, 0, 12)
OpenBtn.BackgroundColor3 = C.bg2
OpenBtn.Text = "⚡ VERON"
OpenBtn.TextColor3 = C.neonGlow
OpenBtn.TextSize = 13
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false
OpenBtn.BorderSizePixel = 0
OpenBtn.Parent = ScreenGui
local OC = Instance.new("UICorner") OC.CornerRadius = UDim.new(0,8) OC.Parent = OpenBtn
local OS = Instance.new("UIStroke") OS.Color = C.neon OS.Thickness = 1 OS.Parent = OpenBtn

-- ================================================
-- MAIN FRAME
-- ================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 500)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -250)
MainFrame.BackgroundColor3 = C.bg
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local MFC = Instance.new("UICorner") MFC.CornerRadius = UDim.new(0,14) MFC.Parent = MainFrame
local MFS = Instance.new("UIStroke") MFS.Color = C.neon MFS.Thickness = 1.5 MFS.Parent = MainFrame

-- ================================================
-- TITLE BAR
-- ================================================
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = C.bg2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TBC = Instance.new("UICorner") TBC.CornerRadius = UDim.new(0,14) TBC.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡  VERON HUB  |  v2.0"
TitleLabel.TextColor3 = C.neonGlow
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = C.red
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar
local CBC = Instance.new("UICorner") CBC.CornerRadius = UDim.new(0,6) CBC.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)
OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- ================================================
-- TAB BAR
-- ================================================
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -16, 0, 32)
TabBar.Position = UDim2.new(0, 8, 0, 48)
TabBar.BackgroundColor3 = C.bg2
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame
local TBRC = Instance.new("UICorner") TBRC.CornerRadius = UDim.new(0,8) TBRC.Parent = TabBar

local TabNames = {"Movement", "Player", "Visual", "Utility"}
local TabBtns = {}
local TabPages = {}

for i, name in ipairs(TabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, -2, 1, -6)
    btn.Position = UDim2.new((i-1)*0.25, 1, 0, 3)
    btn.BackgroundColor3 = C.tabOff
    btn.Text = name
    btn.TextColor3 = C.textDim
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0,6) bc.Parent = btn
    TabBtns[name] = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -16, 1, -92)
    page.Position = UDim2.new(0, 8, 0, 86)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = C.neon
    page.CanvasSize = UDim2.new(0,0,0,0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = i == 1
    page.Parent = MainFrame
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,6)
    layout.Parent = page
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0,4)
    pad.Parent = page
    TabPages[name] = page
end

local function switchTab(name)
    for n, page in pairs(TabPages) do
        page.Visible = n == name
        local btn = TabBtns[n]
        if n == name then
            btn.BackgroundColor3 = C.tabActive
            btn.TextColor3 = C.neonGlow
        else
            btn.BackgroundColor3 = C.tabOff
            btn.TextColor3 = C.textDim
        end
    end
end
for name, btn in pairs(TabBtns) do
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
end
switchTab("Movement")

-- ================================================
-- HELPER: BUAT TOGGLE
-- ================================================
local function createToggle(tabName, label, sublabel, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 48)
    row.BackgroundColor3 = C.bg2
    row.BorderSizePixel = 0
    row.Parent = TabPages[tabName]
    local rc = Instance.new("UICorner") rc.CornerRadius = UDim.new(0,10) rc.Parent = row
    local rs = Instance.new("UIStroke") rs.Color = C.neonDim rs.Thickness = 0.8 rs.Parent = row

    local nameL = Instance.new("TextLabel")
    nameL.Size = UDim2.new(1, -65, 0, 20)
    nameL.Position = UDim2.new(0, 12, 0, 6)
    nameL.BackgroundTransparency = 1
    nameL.Text = label
    nameL.TextColor3 = C.text
    nameL.TextSize = 13
    nameL.Font = Enum.Font.GothamBold
    nameL.TextXAlignment = Enum.TextXAlignment.Left
    nameL.Parent = row

    if sublabel then
        local subL = Instance.new("TextLabel")
        subL.Size = UDim2.new(1, -65, 0, 14)
        subL.Position = UDim2.new(0, 12, 0, 27)
        subL.BackgroundTransparency = 1
        subL.Text = sublabel
        subL.TextColor3 = C.textDim
        subL.TextSize = 11
        subL.Font = Enum.Font.Gotham
        subL.TextXAlignment = Enum.TextXAlignment.Left
        subL.Parent = row
    end

    -- Toggle pill
    local pill = Instance.new("TextButton")
    pill.Size = UDim2.new(0, 46, 0, 24)
    pill.Position = UDim2.new(1, -56, 0.5, -12)
    pill.BackgroundColor3 = C.toggleOff
    pill.Text = ""
    pill.BorderSizePixel = 0
    pill.Parent = row
    local pc = Instance.new("UICorner") pc.CornerRadius = UDim.new(1,0) pc.Parent = pill

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 18, 0, 18)
    dot.Position = UDim2.new(0, 3, 0.5, -9)
    dot.BackgroundColor3 = C.textDim
    dot.BorderSizePixel = 0
    dot.Parent = pill
    local dc = Instance.new("UICorner") dc.CornerRadius = UDim.new(1,0) dc.Parent = dot

    local isOn = false
    local tw = TweenInfo.new(0.18, Enum.EasingStyle.Quad)

    pill.MouseButton1Click:Connect(function()
        isOn = not isOn
        TweenService:Create(pill, tw, {BackgroundColor3 = isOn and C.toggleOn or C.toggleOff}):Play()
        TweenService:Create(dot, tw, {
            Position = isOn and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
            BackgroundColor3 = isOn and C.white or C.textDim,
        }):Play()
        callback(isOn)
    end)

    return row
end

-- ================================================
-- HELPER: SECTION LABEL
-- ================================================
local function createSection(tabName, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  ── " .. text
    lbl.TextColor3 = C.neon
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = TabPages[tabName]
end

-- ================================================
-- TAB: MOVEMENT
-- ================================================
createSection("Movement", "MOVEMENT")

local speedEnabled = false
createToggle("Movement", "Speed Hack", "WalkSpeed × 3", function(s)
    speedEnabled = s
    Humanoid.WalkSpeed = s and 50 or 16
end)

createToggle("Movement", "High Jump", "JumpPower 100", function(s)
    Humanoid.JumpPower = s and 100 or 50
end)

local flyEnabled = false
local flyBV, flyBG
createToggle("Movement", "Fly", "WASD + Space / Shift", function(s)
    flyEnabled = s
    if s then
        flyBV = Instance.new("BodyVelocity")
        flyBV.Velocity = Vector3.new(0,0,0)
        flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
        flyBV.Parent = RootPart
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
        flyBG.CFrame = RootPart.CFrame
        flyBG.Parent = RootPart
        RunService.Heartbeat:Connect(function()
            if not flyEnabled then return end
            local cam = workspace.CurrentCamera
            local dir = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0,1,0) end
            flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * 40 or Vector3.new(0,0,0)
        end)
    else
        if flyBV then flyBV:Destroy() end
        if flyBG then flyBG:Destroy() end
    end
end)

local noclipOn = false
createToggle("Movement", "Noclip", "Tembus tembok", function(s)
    noclipOn = s
    if not s and Character then
        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.CanCollide = true
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if noclipOn and Character then
        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

-- ================================================
-- TAB: PLAYER
-- ================================================
createSection("Player", "PLAYER")

local godOn = false
createToggle("Player", "God Mode", "HP selalu penuh", function(s) godOn = s end)

createToggle("Player", "Infinite Jump", "Lompat terus di udara", function(s)
    -- handled di event bawah
    _G.InfJump = s
end)
_G.InfJump = false

UserInputService.JumpRequest:Connect(function()
    if _G.InfJump and Character then
        local hum = Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

createSection("Player", "SURVIVAL")

createToggle("Player", "Anti Ragdoll", "Cegah karakter jatuh kaku", function(s)
    _G.AntiRagdoll = s
end)
_G.AntiRagdoll = false

createToggle("Player", "Infinite Stamina", "Stamina selalu penuh", function(s)
    _G.InfStamina = s
end)
_G.InfStamina = false

RunService.Heartbeat:Connect(function()
    if not Character then return end
    local hum = Character:FindFirstChildOfClass("Humanoid")
    if godOn and hum then hum.Health = hum.MaxHealth end
    if _G.AntiRagdoll then
        for _, v in ipairs(Character:GetDescendants()) do
            if v:IsA("BallSocketConstraint") or v:IsA("HingeConstraint") then v.Enabled = false end
            if v.Name:lower():find("ragdoll") and v:IsA("BoolValue") then v.Value = false end
        end
    end
    if _G.InfStamina then
        for _, v in ipairs(Character:GetDescendants()) do
            if (v.Name:lower():find("stam") or v.Name:lower():find("ener")) and (v:IsA("NumberValue") or v:IsA("IntValue")) then
                v.Value = 100
            end
        end
    end
end)

-- ================================================
-- TAB: VISUAL
-- ================================================
createSection("Visual", "ESP")

local espOn = false
local espObjects = {}

local function addESP(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if not char or espObjects[player] then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(168,85,247)
    hl.FillTransparency = 0.75
    hl.OutlineColor = C.neonGlow
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char

    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0,140,0,38)
    bb.StudsOffset = Vector3.new(0,3,0)
    bb.AlwaysOnTop = true
    bb.Adornee = hrp
    bb.Parent = hrp

    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(1,0,0.55,0)
    nl.BackgroundTransparency = 1
    nl.Text = player.Name
    nl.TextColor3 = C.neonGlow
    nl.TextStrokeTransparency = 0
    nl.Font = Enum.Font.GothamBold
    nl.TextSize = 13
    nl.Parent = bb

    local dl = Instance.new("TextLabel")
    dl.Name = "Dist"
    dl.Size = UDim2.new(1,0,0.45,0)
    dl.Position = UDim2.new(0,0,0.55,0)
    dl.BackgroundTransparency = 1
    dl.Text = "-- m"
    dl.TextColor3 = C.text
    dl.TextStrokeTransparency = 0
    dl.Font = Enum.Font.Gotham
    dl.TextSize = 11
    dl.Parent = bb

    espObjects[player] = {hl=hl, bb=bb, dl=dl}
end

local function removeESP(player)
    local o = espObjects[player]
    if o then
        if o.hl then o.hl:Destroy() end
        if o.bb then o.bb:Destroy() end
        espObjects[player] = nil
    end
end

createToggle("Visual", "ESP Players", "Lihat player tembus tembok", function(s)
    espOn = s
    if s then for _, p in ipairs(Players:GetPlayers()) do addESP(p) end
    else for p in pairs(espObjects) do removeESP(p) end end
end)

local espItemOn = false
local espItemObjects = {}

createToggle("Visual", "ESP Items", "Highlight money & drop item", function(s)
    espItemOn = s
    if not s then
        for _, hl in pairs(espItemObjects) do if hl then hl:Destroy() end end
        espItemObjects = {}
    end
end)

createSection("Visual", "VISUAL FX")

createToggle("Visual", "Fullbright", "Map jadi terang semua", function(s)
    if s then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = originalLighting.Brightness
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.FogEnd = originalLighting.FogEnd
        Lighting.GlobalShadows = originalLighting.GlobalShadows
    end
end)

local fpsBoosted = false
createToggle("Visual", "FPS Booster", "Matikan efek berat", function(s)
    fpsBoosted = s
    Lighting.GlobalShadows = not s
    if s then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, o in ipairs(workspace:GetDescendants()) do
            if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Smoke") or o:IsA("Fire") then
                o.Enabled = false
            end
        end
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        for _, o in ipairs(workspace:GetDescendants()) do
            if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Smoke") or o:IsA("Fire") then
                o.Enabled = true
            end
        end
    end
end)

-- Update ESP jarak & item setiap frame
RunService.Heartbeat:Connect(function()
    if espOn and RootPart and RootPart.Parent then
        for player, obj in pairs(espObjects) do
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and obj.dl then
                obj.dl.Text = math.floor((hrp.Position - RootPart.Position).Magnitude) .. " studs"
            end
        end
    end
    if espItemOn then
        for _, obj in ipairs(workspace:GetDescendants()) do
            local n = obj.Name:lower()
            if obj:IsA("BasePart") and (n:find("money") or n:find("cash") or n:find("drop") or n:find("item")) and not espItemObjects[obj] then
                local hl = Instance.new("Highlight")
                hl.FillColor = Color3.fromRGB(250,204,21)
                hl.OutlineColor = Color3.fromRGB(255,255,255)
                hl.FillTransparency = 0.5
                hl.Parent = obj
                espItemObjects[obj] = hl
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if espOn then task.wait(0.5) removeESP(p) addESP(p) end
    end)
end)
Players.PlayerRemoving:Connect(function(p) removeESP(p) end)

-- ================================================
-- TAB: UTILITY
-- ================================================
createSection("Utility", "TELEPORT")

local TpFrame = Instance.new("Frame")
TpFrame.Size = UDim2.new(1, 0, 0, 42)
TpFrame.BackgroundColor3 = C.bg2
TpFrame.BorderSizePixel = 0
TpFrame.Parent = TabPages["Utility"]
local TpFC = Instance.new("UICorner") TpFC.CornerRadius = UDim.new(0,10) TpFC.Parent = TpFrame
local TpFS = Instance.new("UIStroke") TpFS.Color = C.neonDim TpFS.Thickness = 0.8 TpFS.Parent = TpFrame

local TpBox = Instance.new("TextBox")
TpBox.Size = UDim2.new(0.58, -8, 1, -12)
TpBox.Position = UDim2.new(0, 8, 0, 6)
TpBox.BackgroundColor3 = C.bg
TpBox.Text = ""
TpBox.PlaceholderText = "Nama player..."
TpBox.TextColor3 = C.text
TpBox.PlaceholderColor3 = C.textDim
TpBox.TextSize = 12
TpBox.Font = Enum.Font.Gotham
TpBox.BorderSizePixel = 0
TpBox.ClearTextOnFocus = false
TpBox.Parent = TpFrame
local TpBC = Instance.new("UICorner") TpBC.CornerRadius = UDim.new(0,6) TpBC.Parent = TpBox

local TpBtn = Instance.new("TextButton")
TpBtn.Size = UDim2.new(0.42, -8, 1, -12)
TpBtn.Position = UDim2.new(0.58, 4, 0, 6)
TpBtn.BackgroundColor3 = C.neonDim
TpBtn.Text = "➜ Teleport"
TpBtn.TextColor3 = C.neonGlow
TpBtn.TextSize = 12
TpBtn.Font = Enum.Font.GothamBold
TpBtn.BorderSizePixel = 0
TpBtn.Parent = TpFrame
local TpBtnC = Instance.new("UICorner") TpBtnC.CornerRadius = UDim.new(0,6) TpBtnC.Parent = TpBtn

TpBtn.MouseButton1Click:Connect(function()
    local name = TpBox.Text:lower()
    if name == "" then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(name) and p ~= LocalPlayer then
            local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if hrp and RootPart then
                RootPart.CFrame = hrp.CFrame + Vector3.new(0,3,0)
            end
            break
        end
    end
end)

createSection("Utility", "WAYPOINT")

local WpSaveFrame = Instance.new("Frame")
WpSaveFrame.Size = UDim2.new(1, 0, 0, 42)
WpSaveFrame.BackgroundColor3 = C.bg2
WpSaveFrame.BorderSizePixel = 0
WpSaveFrame.Parent = TabPages["Utility"]
local WSC = Instance.new("UICorner") WSC.CornerRadius = UDim.new(0,10) WSC.Parent = WpSaveFrame
local WSS = Instance.new("UIStroke") WSS.Color = C.neonDim WSS.Thickness = 0.8 WSS.Parent = WpSaveFrame

local WpBox = Instance.new("TextBox")
WpBox.Size = UDim2.new(0.58, -8, 1, -12)
WpBox.Position = UDim2.new(0, 8, 0, 6)
WpBox.BackgroundColor3 = C.bg
WpBox.Text = ""
WpBox.PlaceholderText = "Nama waypoint..."
WpBox.TextColor3 = C.text
WpBox.PlaceholderColor3 = C.textDim
WpBox.TextSize = 12
WpBox.Font = Enum.Font.Gotham
WpBox.BorderSizePixel = 0
WpBox.ClearTextOnFocus = false
WpBox.Parent = WpSaveFrame
local WBC = Instance.new("UICorner") WBC.CornerRadius = UDim.new(0,6) WBC.Parent = WpBox

local WpSaveBtn = Instance.new("TextButton")
WpSaveBtn.Size = UDim2.new(0.42, -8, 1, -12)
WpSaveBtn.Position = UDim2.new(0.58, 4, 0, 6)
WpSaveBtn.BackgroundColor3 = C.neonDim
WpSaveBtn.Text = "💾 Simpan"
WpSaveBtn.TextColor3 = C.neonGlow
WpSaveBtn.TextSize = 12
WpSaveBtn.Font = Enum.Font.GothamBold
WpSaveBtn.BorderSizePixel = 0
WpSaveBtn.Parent = WpSaveFrame
local WpSC = Instance.new("UICorner") WpSC.CornerRadius = UDim.new(0,6) WpSC.Parent = WpSaveBtn

local savedWaypoints = {}
local wpCount = 0

local function addWpRow(name, cf)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 38)
    row.BackgroundColor3 = C.bg3
    row.BorderSizePixel = 0
    row.Parent = TabPages["Utility"]
    local rc = Instance.new("UICorner") rc.CornerRadius = UDim.new(0,8) rc.Parent = row

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, -4, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "📍 " .. name
    lbl.TextColor3 = C.text
    lbl.TextSize = 11
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextTruncate = Enum.TextTruncate.AtEnd
    lbl.Parent = row

    local goBtn = Instance.new("TextButton")
    goBtn.Size = UDim2.new(0.26, -4, 0, 26)
    goBtn.Position = UDim2.new(0.5, 4, 0.5, -13)
    goBtn.BackgroundColor3 = Color3.fromRGB(21,128,61)
    goBtn.Text = "Go"
    goBtn.TextColor3 = C.white
    goBtn.TextSize = 11
    goBtn.Font = Enum.Font.GothamBold
    goBtn.BorderSizePixel = 0
    goBtn.Parent = row
    local gc = Instance.new("UICorner") gc.CornerRadius = UDim.new(0,6) gc.Parent = goBtn

    local delBtn = Instance.new("TextButton")
    delBtn.Size = UDim2.new(0.24, -4, 0, 26)
    delBtn.Position = UDim2.new(0.76, 0, 0.5, -13)
    delBtn.BackgroundColor3 = Color3.fromRGB(153,27,27)
    delBtn.Text = "✕"
    delBtn.TextColor3 = C.white
    delBtn.TextSize = 11
    delBtn.Font = Enum.Font.GothamBold
    delBtn.BorderSizePixel = 0
    delBtn.Parent = row
    local dc = Instance.new("UICorner") dc.CornerRadius = UDim.new(0,6) dc.Parent = delBtn

    goBtn.MouseButton1Click:Connect(function()
        if RootPart and RootPart.Parent then RootPart.CFrame = cf end
    end)
    delBtn.MouseButton1Click:Connect(function()
        savedWaypoints[name] = nil
        row:Destroy()
    end)
end

WpSaveBtn.MouseButton1Click:Connect(function()
    if not RootPart or not RootPart.Parent then return end
    wpCount = wpCount + 1
    local name = WpBox.Text ~= "" and WpBox.Text or ("Waypoint " .. wpCount)
    savedWaypoints[name] = RootPart.CFrame
    addWpRow(name, RootPart.CFrame)
    WpBox.Text = ""
end)

createSection("Utility", "MISC")

createToggle("Utility", "Anti AFK", "Cegah kick saat idle", function(s)
    _G.AntiAFK = s
end)
_G.AntiAFK = false

local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if _G.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

createToggle("Utility", "Auto Collect", "Vacuum money & item terdekat", function(s)
    _G.AutoCollect = s
end)
_G.AutoCollect = false

task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoCollect then
            local root = Character and Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    local n = obj.Name:lower()
                    if obj:IsA("BasePart") and (n:find("money") or n:find("cash") or n:find("drop")) then
                        if (obj.Position - root.Position).Magnitude <= 30 then
                            obj.CFrame = root.CFrame
                        end
                    end
                end
            end
        end
    end
end)

-- ================================================
-- RESPAWN HANDLER
-- ================================================
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)

-- ================================================
-- KEYBIND: RightCtrl = hide/show
-- ================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
        OpenBtn.Visible = not MainFrame.Visible
    end
end)

-- ================================================
print("✅ Veron Hub v2.0 loaded!")
print("   RightCtrl = hide/show GUI")
-- ================================================
