-- ================================================
--   VERON HUB v3.3 - Roblox Executor
--   UI: Dark Purple Neon | Tab System
--   Made by Veron
-- ================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

local originalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    GlobalShadows = Lighting.GlobalShadows,
}

_G.VeronConfig = _G.VeronConfig or {}

-- ================================================
-- THEMES
-- ================================================
local Themes = {
    Purple = {
        bg=Color3.fromRGB(10,8,20), bg2=Color3.fromRGB(18,14,35), bg3=Color3.fromRGB(26,20,50),
        neon=Color3.fromRGB(168,85,247), neonDim=Color3.fromRGB(88,28,135), neonGlow=Color3.fromRGB(196,132,252),
        tabActive=Color3.fromRGB(88,28,135),
    },
    Blue = {
        bg=Color3.fromRGB(8,12,24), bg2=Color3.fromRGB(12,20,40), bg3=Color3.fromRGB(18,30,58),
        neon=Color3.fromRGB(59,130,246), neonDim=Color3.fromRGB(29,78,216), neonGlow=Color3.fromRGB(147,197,253),
        tabActive=Color3.fromRGB(29,78,216),
    },
    Red = {
        bg=Color3.fromRGB(20,8,8), bg2=Color3.fromRGB(35,12,12), bg3=Color3.fromRGB(50,18,18),
        neon=Color3.fromRGB(239,68,68), neonDim=Color3.fromRGB(153,27,27), neonGlow=Color3.fromRGB(252,165,165),
        tabActive=Color3.fromRGB(153,27,27),
    },
    Green = {
        bg=Color3.fromRGB(8,20,10), bg2=Color3.fromRGB(12,35,16), bg3=Color3.fromRGB(18,50,22),
        neon=Color3.fromRGB(34,197,94), neonDim=Color3.fromRGB(21,128,61), neonGlow=Color3.fromRGB(134,239,172),
        tabActive=Color3.fromRGB(21,128,61),
    },
    Pink = {
        bg=Color3.fromRGB(20,8,16), bg2=Color3.fromRGB(36,12,28), bg3=Color3.fromRGB(54,18,42),
        neon=Color3.fromRGB(236,72,153), neonDim=Color3.fromRGB(190,24,93), neonGlow=Color3.fromRGB(249,168,212),
        tabActive=Color3.fromRGB(190,24,93),
    },
    Gold = {
        bg=Color3.fromRGB(20,16,7), bg2=Color3.fromRGB(38,30,12), bg3=Color3.fromRGB(55,44,18),
        neon=Color3.fromRGB(234,179,8), neonDim=Color3.fromRGB(161,98,7), neonGlow=Color3.fromRGB(253,230,138),
        tabActive=Color3.fromRGB(161,98,7),
    },
    Midnight = {
        bg=Color3.fromRGB(5,7,14), bg2=Color3.fromRGB(10,15,28), bg3=Color3.fromRGB(16,23,42),
        neon=Color3.fromRGB(99,102,241), neonDim=Color3.fromRGB(67,56,202), neonGlow=Color3.fromRGB(165,180,252),
        tabActive=Color3.fromRGB(67,56,202),
    },
}

local currentTheme = _G.VeronConfig.theme or "Purple"
local C = {}
local function applyTheme(name)
    currentTheme = name
    _G.VeronConfig.theme = name
    local t = Themes[name]
    C.bg=t.bg C.bg2=t.bg2 C.bg3=t.bg3
    C.neon=t.neon C.neonDim=t.neonDim C.neonGlow=t.neonGlow
    C.tabActive=t.tabActive C.tabOff=t.bg2
    C.text=Color3.fromRGB(230,220,255) C.textDim=Color3.fromRGB(120,100,160)
    C.toggleOn=t.neon C.toggleOff=Color3.fromRGB(35,28,60)
    C.white=Color3.fromRGB(255,255,255)
    C.green=Color3.fromRGB(74,222,128) C.red=Color3.fromRGB(248,113,113)
end
applyTheme(currentTheme)

-- ================================================
-- CLEANUP
-- ================================================
if game.CoreGui:FindFirstChild("Veron") then game.CoreGui.Veron:Destroy() end

-- ================================================
-- SCREEN GUI
-- ================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Veron"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local guiParent = game.CoreGui
pcall(function()
    if typeof(gethui) == "function" then
        guiParent = gethui()
    end
end)
ScreenGui.Parent = guiParent

-- Open Button
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0,110,0,32)
OpenBtn.Position = UDim2.new(0,12,0,12)
OpenBtn.BackgroundColor3 = C.bg2
OpenBtn.Text = "⚡ VERON"
OpenBtn.TextColor3 = C.neonGlow
OpenBtn.TextSize = 13
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false
OpenBtn.BorderSizePixel = 0
OpenBtn.Parent = ScreenGui
local OC=Instance.new("UICorner") OC.CornerRadius=UDim.new(0,8) OC.Parent=OpenBtn
local OS=Instance.new("UIStroke") OS.Color=C.neon OS.Thickness=1 OS.Parent=OpenBtn

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0,340,0,520)
MainFrame.Position = UDim2.new(0.5,-170,0.5,-260)
MainFrame.BackgroundColor3 = C.bg
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local MFC=Instance.new("UICorner") MFC.CornerRadius=UDim.new(0,14) MFC.Parent=MainFrame
local MFS=Instance.new("UIStroke") MFS.Color=C.neon MFS.Thickness=1.5 MFS.Parent=MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1,0,0,44)
TitleBar.BackgroundColor3 = C.bg2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TBC=Instance.new("UICorner") TBC.CornerRadius=UDim.new(0,14) TBC.Parent=TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1,-50,1,0)
TitleLabel.Position = UDim2.new(0,14,0,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡  VERON HUB  |  v3.3"
TitleLabel.TextColor3 = C.neonGlow
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,28,0,28)
CloseBtn.Position = UDim2.new(1,-36,0.5,-14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(80,20,20)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = C.red
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar
local CBC=Instance.new("UICorner") CBC.CornerRadius=UDim.new(0,6) CBC.Parent=CloseBtn

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible=false OpenBtn.Visible=true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible=true OpenBtn.Visible=false end)

-- ================================================
-- TAB BAR (5 tabs)
-- ================================================
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1,-16,0,30)
TabBar.Position = UDim2.new(0,8,0,48)
TabBar.BackgroundColor3 = C.bg2
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame
local TBRC=Instance.new("UICorner") TBRC.CornerRadius=UDim.new(0,8) TBRC.Parent=TabBar

local TabNames = {"Movement","Combat","Visual","Utility","Extra"}
local TabBtns = {}
local TabPages = {}

for i,name in ipairs(TabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.2,-2,1,-6)
    btn.Position = UDim2.new((i-1)*0.2,1,0,3)
    btn.BackgroundColor3 = C.tabOff
    btn.Text = name
    btn.TextColor3 = C.textDim
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(0,6) bc.Parent=btn
    TabBtns[name] = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1,-16,1,-92)
    page.Position = UDim2.new(0,8,0,84)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = C.neon
    page.CanvasSize = UDim2.new(0,0,0,0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = i==1
    page.Parent = MainFrame
    local layout=Instance.new("UIListLayout") layout.Padding=UDim.new(0,6) layout.Parent=page
    local pad=Instance.new("UIPadding") pad.PaddingTop=UDim.new(0,4) pad.Parent=page
    TabPages[name] = page
end

local function switchTab(name)
    for n,page in pairs(TabPages) do
        page.Visible = n==name
        local btn = TabBtns[n]
        btn.BackgroundColor3 = n==name and C.tabActive or C.tabOff
        btn.TextColor3 = n==name and C.neonGlow or C.textDim
    end
end
for name,btn in pairs(TabBtns) do btn.MouseButton1Click:Connect(function() switchTab(name) end) end
switchTab("Movement")

-- ================================================
-- TOAST SYSTEM
-- ================================================
local toastQueue = {}
local toastBusy = false

local function showToast(msg, isOn)
    table.insert(toastQueue, {msg=msg, on=isOn})
    if toastBusy then return end
    toastBusy = true
    task.spawn(function()
        while #toastQueue > 0 do
            local d = table.remove(toastQueue,1)
            local toast = Instance.new("Frame")
            toast.Size = UDim2.new(0,200,0,38)
            toast.Position = UDim2.new(1,10,1,-48)
            toast.BackgroundColor3 = C.bg2
            toast.BorderSizePixel = 0
            toast.Parent = ScreenGui
            local tc=Instance.new("UICorner") tc.CornerRadius=UDim.new(0,10) tc.Parent=toast
            local ts=Instance.new("UIStroke") ts.Color=d.on and C.neon or C.textDim ts.Thickness=1 ts.Parent=toast
            local dot=Instance.new("Frame")
            dot.Size=UDim2.new(0,7,0,7) dot.Position=UDim2.new(0,10,0.5,-3.5)
            dot.BackgroundColor3=d.on and C.green or C.red dot.BorderSizePixel=0 dot.Parent=toast
            local dc=Instance.new("UICorner") dc.CornerRadius=UDim.new(1,0) dc.Parent=dot
            local lbl=Instance.new("TextLabel")
            lbl.Size=UDim2.new(1,-26,1,0) lbl.Position=UDim2.new(0,24,0,0)
            lbl.BackgroundTransparency=1
            lbl.Text=d.msg..(d.on and " ON" or " OFF")
            lbl.TextColor3=d.on and C.neonGlow or C.textDim
            lbl.TextSize=11 lbl.Font=Enum.Font.GothamBold
            lbl.TextXAlignment=Enum.TextXAlignment.Left lbl.Parent=toast
            TweenService:Create(toast,TweenInfo.new(0.2),{Position=UDim2.new(1,-210,1,-48)}):Play()
            task.wait(2)
            local tw=TweenService:Create(toast,TweenInfo.new(0.2),{Position=UDim2.new(1,10,1,-48)})
            tw:Play() tw.Completed:Wait() toast:Destroy()
        end
        toastBusy = false
    end)
end

-- ================================================
-- HELPERS
-- ================================================
local function createSection(tab, text)
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,0,0,18)
    lbl.BackgroundTransparency=1
    lbl.Text="  ── "..text
    lbl.TextColor3=C.neon lbl.TextSize=10
    lbl.Font=Enum.Font.GothamBold
    lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=TabPages[tab]
end

local function createToggle(tab, label, sub, cb)
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,0,0,48)
    row.BackgroundColor3=C.bg2 row.BorderSizePixel=0
    row.Parent=TabPages[tab]
    local rc=Instance.new("UICorner") rc.CornerRadius=UDim.new(0,10) rc.Parent=row
    local rs=Instance.new("UIStroke") rs.Color=C.neonDim rs.Thickness=0.8 rs.Parent=row

    local nl=Instance.new("TextLabel")
    nl.Size=UDim2.new(1,-65,0,20) nl.Position=UDim2.new(0,12,0,6)
    nl.BackgroundTransparency=1 nl.Text=label
    nl.TextColor3=C.text nl.TextSize=13
    nl.Font=Enum.Font.GothamBold nl.TextXAlignment=Enum.TextXAlignment.Left
    nl.Parent=row

    if sub then
        local sl=Instance.new("TextLabel")
        sl.Size=UDim2.new(1,-65,0,14) sl.Position=UDim2.new(0,12,0,28)
        sl.BackgroundTransparency=1 sl.Text=sub
        sl.TextColor3=C.textDim sl.TextSize=11
        sl.Font=Enum.Font.Gotham sl.TextXAlignment=Enum.TextXAlignment.Left
        sl.Parent=row
    end

    local pill=Instance.new("TextButton")
    pill.Size=UDim2.new(0,46,0,24)
    pill.Position=UDim2.new(1,-56,0.5,-12)
    pill.BackgroundColor3=C.toggleOff pill.Text=""
    pill.BorderSizePixel=0 pill.Parent=row
    local pc=Instance.new("UICorner") pc.CornerRadius=UDim.new(1,0) pc.Parent=pill

    local dot=Instance.new("Frame")
    dot.Size=UDim2.new(0,18,0,18)
    dot.Position=UDim2.new(0,3,0.5,-9)
    dot.BackgroundColor3=C.textDim dot.BorderSizePixel=0
    dot.Parent=pill
    local dc=Instance.new("UICorner") dc.CornerRadius=UDim.new(1,0) dc.Parent=dot

    local isOn=false
    local tw=TweenInfo.new(0.18,Enum.EasingStyle.Quad)
    pill.MouseButton1Click:Connect(function()
        isOn=not isOn
        TweenService:Create(pill,tw,{BackgroundColor3=isOn and C.toggleOn or C.toggleOff}):Play()
        TweenService:Create(dot,tw,{
            Position=isOn and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
            BackgroundColor3=isOn and C.white or C.textDim,
        }):Play()
        showToast(label, isOn)
        _G.VeronConfig[tab.."_"..label] = isOn
        cb(isOn)
    end)
    return row
end

-- ================================================
-- TAB: MOVEMENT
-- ================================================
createSection("Movement","MOVEMENT")

createToggle("Movement","Speed Hack","WalkSpeed 50",function(s)
    if Character then
        local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=s and 50 or 16 end
    end
end)

createToggle("Movement","High Jump","JumpPower 100",function(s)
    if Character then
        local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h.JumpPower=s and 100 or 50 end
    end
end)

local flyOn = false
local flyConn = nil

local function stopFly()
    flyOn = false
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local rp = Character and Character:FindFirstChild("HumanoidRootPart")
    local hum = Character and Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
    if rp then rp.AssemblyLinearVelocity = Vector3.zero end
end

local function startFly()
    local rp = Character and Character:FindFirstChild("HumanoidRootPart")
    local hum = Character and Character:FindFirstChildOfClass("Humanoid")
    if not rp or not hum then return end
    if flyConn then flyConn:Disconnect() flyConn = nil end
    flyOn = true
    hum.PlatformStand = true

    flyConn = RunService.Heartbeat:Connect(function(dt)
        rp = Character and Character:FindFirstChild("HumanoidRootPart")
        hum = Character and Character:FindFirstChildOfClass("Humanoid")
        if not flyOn or not rp or not hum then stopFly() return end

        hum.PlatformStand = true

        local spd = 60
        local dir = Vector3.zero
        local cam = workspace.CurrentCamera.CFrame

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0,1,0) end

        if dir.Magnitude > 0 then
            rp.AssemblyLinearVelocity = dir.Unit * spd
        else
            rp.AssemblyLinearVelocity = Vector3.zero
        end
    end)
end

createToggle("Movement","Fly","WASD + Space / Shift",function(s)
    if s then startFly() else stopFly() end
end)

-- Speed Slider
do
    local sRow=Instance.new("Frame")
    sRow.Size=UDim2.new(1,0,0,48) sRow.BackgroundColor3=C.bg2 sRow.BorderSizePixel=0
    sRow.Parent=TabPages["Movement"]
    local sRC=Instance.new("UICorner") sRC.CornerRadius=UDim.new(0,10) sRC.Parent=sRow
    local sRS=Instance.new("UIStroke") sRS.Color=C.neonDim sRS.Thickness=0.8 sRS.Parent=sRow
    local sLbl=Instance.new("TextLabel")
    sLbl.Size=UDim2.new(1,-10,0,18) sLbl.Position=UDim2.new(0,12,0,4)
    sLbl.BackgroundTransparency=1 sLbl.Text="Walk Speed: 16"
    sLbl.TextColor3=C.text sLbl.TextSize=12
    sLbl.Font=Enum.Font.GothamBold sLbl.TextXAlignment=Enum.TextXAlignment.Left sLbl.Parent=sRow
    local sTrk=Instance.new("Frame")
    sTrk.Size=UDim2.new(1,-24,0,6) sTrk.Position=UDim2.new(0,12,0,32)
    sTrk.BackgroundColor3=C.bg3 sTrk.BorderSizePixel=0 sTrk.Parent=sRow
    local sTC=Instance.new("UICorner") sTC.CornerRadius=UDim.new(1,0) sTC.Parent=sTrk
    local sFill=Instance.new("Frame")
    sFill.Size=UDim2.new(0,0,1,0) sFill.BackgroundColor3=C.neon sFill.BorderSizePixel=0 sFill.Parent=sTrk
    local sFC=Instance.new("UICorner") sFC.CornerRadius=UDim.new(1,0) sFC.Parent=sFill
    local sThumb=Instance.new("TextButton")
    sThumb.Size=UDim2.new(0,14,0,14) sThumb.AnchorPoint=Vector2.new(0.5,0.5)
    sThumb.Position=UDim2.new(0,0,0.5,0) sThumb.BackgroundColor3=C.neonGlow
    sThumb.Text="" sThumb.BorderSizePixel=0 sThumb.Parent=sTrk
    local sTC2=Instance.new("UICorner") sTC2.CornerRadius=UDim.new(1,0) sTC2.Parent=sThumb
    local minSpd,maxSpd=16,500
    local sDrag=false
    local function updateSpeed(pct)
        pct=math.clamp(pct,0,1)
        local spd=math.floor(minSpd+(maxSpd-minSpd)*pct)
        sFill.Size=UDim2.new(pct,0,1,0)
        sThumb.Position=UDim2.new(pct,0,0.5,0)
        sLbl.Text="Walk Speed: "..spd
        local h=Character and Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=spd end
    end
    local function onSInput(x)
        local abs=sTrk.AbsolutePosition.X local w=sTrk.AbsoluteSize.X
        updateSpeed((x-abs)/w)
    end
    sThumb.MouseButton1Down:Connect(function() sDrag=true end)
    sTrk.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch then sDrag=true onSInput(i.Position.X) end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if not sDrag then return end
        if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
            onSInput(i.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sDrag=false end
    end)
end

-- Blink (dash ke arah kamera)
createToggle("Movement","Blink","Q = dash instan ke depan",function(s) _G.BlinkOn=s end)
_G.BlinkOn=false
UserInputService.InputBegan:Connect(function(input,gp)
    if gp then return end
    if _G.BlinkOn and input.KeyCode==Enum.KeyCode.Q then
        local rp=Character and Character:FindFirstChild("HumanoidRootPart")
        if rp then
            rp.CFrame = rp.CFrame + Camera.CFrame.LookVector * 30
        end
    end
end)

-- Teleport to Cursor
createToggle("Movement","TP to Cursor","Klik titik di map, teleport ke sana",function(s) _G.TpCursor=s end)
_G.TpCursor=false
local mouse=LocalPlayer:GetMouse()
mouse.Button2Down:Connect(function()
    if not _G.TpCursor then return end
    local rp=Character and Character:FindFirstChild("HumanoidRootPart")
    if rp and mouse.Target then
        rp.CFrame=CFrame.new(mouse.Hit.Position+Vector3.new(0,3,0))
    end
end)

local noclipOn=false
createToggle("Movement","Noclip","Tembus tembok",function(s)
    noclipOn=s
    if not s and Character then
        for _,p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.CanCollide=true end
        end
    end
end)

RunService.Stepped:Connect(function()
    if noclipOn and Character then
        for _,p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide=false end
        end
    end
end)

-- ================================================
-- TAB: COMBAT
-- ================================================
createSection("Combat","COMBAT")

local godOn=false
createToggle("Combat","God Mode","HP selalu penuh",function(s) godOn=s end)

createToggle("Combat","Infinite Jump","Lompat terus di udara",function(s) _G.InfJump=s end)
_G.InfJump=false
UserInputService.JumpRequest:Connect(function()
    if _G.InfJump and Character then
        local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

createToggle("Combat","Anti Ragdoll","Cegah karakter kaku",function(s) _G.AntiRagdoll=s end)
_G.AntiRagdoll=false

createToggle("Combat","Infinite Stamina","Stamina selalu penuh",function(s) _G.InfStamina=s end)
_G.InfStamina=false

createSection("Combat","ADMIN / TEST COMBAT")
local combatTestEnabled = {
    HitboxTest = false,
    RecoilTest = false,
    SpreadTest = false,
}
createToggle("Combat","Hitbox Test","Test hitbox settings for your own game",function(v)
    combatTestEnabled.HitboxTest=v
    showToast("Hitbox Test: "..(v and "ON" or "OFF"),v)
end)
createToggle("Combat","No Recoil Test","Test weapon recoil behavior in your own game",function(v)
    combatTestEnabled.RecoilTest=v
    showToast("No Recoil Test: "..(v and "ON" or "OFF"),v)
end)
createToggle("Combat","No Spread Test","Test weapon spread behavior in your own game",function(v)
    combatTestEnabled.SpreadTest=v
    showToast("No Spread Test: "..(v and "ON" or "OFF"),v)
end)

-- Aimbot Lock-On (hold RightAlt / mobile button)
createSection("Combat","AIMBOT")
local aimbotOn=false
local aimbotLocked=nil
createToggle("Combat","Aimbot Lock-On","Hold RAlt (PC) untuk lock target",function(s)
    aimbotOn=s
    if not s then aimbotLocked=nil end
end)

RunService.RenderStepped:Connect(function()
    if not aimbotOn then return end
    local holding=UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)
    -- Mobile: cek touch dengan 2 jari (pinch gesture sebagai trigger)
    if isMobile then
        local touches=UserInputService:GetKeysPressed()
        -- pakai silentAimTarget sebagai proxy lock jika mobile
        holding=silentAimOn and silentAimTarget~=nil
    end
    if holding then
        local t=getClosestTarget()
        aimbotLocked=t
    end
    if aimbotLocked and aimbotLocked.Parent then
        local cf=Camera.CFrame
        local targetPos=aimbotLocked.Position
        Camera.CFrame=cf:Lerp(CFrame.lookAt(cf.Position,targetPos),0.25)
    else
        aimbotLocked=nil
    end
end)

createSection("Combat","GUN MODS")

-- ================================================
-- SILENT AIM UNIVERSAL SYSTEM
-- ================================================
local silentAimOn = false
local silentAimFOV = 120
local silentAimTarget = nil
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- FOV Circle Visual
local fovCircle = nil
pcall(function()
    fovCircle = Drawing.new("Circle")
    fovCircle.Visible = false
    fovCircle.Thickness = 1.5
    fovCircle.Color = C.neon
    fovCircle.Transparency = 0.6
    fovCircle.Filled = false
    fovCircle.NumSides = 64
    fovCircle.Radius = silentAimFOV
    fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
end)

-- Cari target terdekat dari pusat layar dalam FOV
local function getClosestTarget()
    local vp = Camera.ViewportSize
    local center = Vector2.new(vp.X/2, vp.Y/2)
    local closest, closestDist = nil, silentAimFOV
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild("Head")
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local aim = head or hrp
            if aim and hum and hum.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(aim.Position)
                if onScreen then
                    local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist2D < closestDist then
                        closestDist = dist2D
                        closest = aim
                    end
                end
            end
        end
    end
    return closest
end

-- Hook metatable (executor env) atau fallback camera lerp
local mouseHookActive = false
local function applyMouseHook()
    if mouseHookActive then return end
    mouseHookActive = true
    local ok = pcall(function()
        local mt = getrawmetatable(game)
        local oldIndex = mt.__index
        setreadonly(mt, false)
        mt.__index = newcclosure(function(self, key)
            if silentAimOn and self == LocalPlayer:GetMouse() then
                local t = getClosestTarget()
                silentAimTarget = t
                if t then
                    if key == "Hit" then return CFrame.new(t.Position)
                    elseif key == "Target" then return t end
                end
            end
            return oldIndex(self, key)
        end)
        setreadonly(mt, true)
    end)
    if not ok then
        -- Fallback: camera snap per-frame (works tanpa full executor)
        RunService.RenderStepped:Connect(function()
            if not silentAimOn then silentAimTarget = nil return end
            local t = getClosestTarget()
            silentAimTarget = t
            if t then
                local cf = Camera.CFrame
                Camera.CFrame = cf:Lerp(CFrame.lookAt(cf.Position, t.Position), 0.35)
            end
        end)
    end
end

-- Update FOV circle & target lock per frame
RunService.RenderStepped:Connect(function()
    if fovCircle then
        pcall(function()
            local vp = Camera.ViewportSize
            fovCircle.Position = Vector2.new(vp.X/2, vp.Y/2)
            fovCircle.Radius = silentAimFOV
            fovCircle.Color = C.neon
            fovCircle.Visible = silentAimOn
        end)
    end
    if silentAimOn then
        silentAimTarget = getClosestTarget()
    end
end)

createToggle("Combat","Silent Aim","Universal: Mouse & Mobile + FOV circle",function(s)
    silentAimOn = s
    if s then applyMouseHook() end
    if fovCircle then pcall(function() fovCircle.Visible = s end) end
end)

-- FOV Slider
do
    local sliderRow=Instance.new("Frame")
    sliderRow.Size=UDim2.new(1,0,0,48)
    sliderRow.BackgroundColor3=C.bg2 sliderRow.BorderSizePixel=0
    sliderRow.Parent=TabPages["Combat"]
    local src=Instance.new("UICorner") src.CornerRadius=UDim.new(0,10) src.Parent=sliderRow
    local srs=Instance.new("UIStroke") srs.Color=C.neonDim srs.Thickness=0.8 srs.Parent=sliderRow
    local slbl=Instance.new("TextLabel")
    slbl.Size=UDim2.new(1,-10,0,18) slbl.Position=UDim2.new(0,12,0,4)
    slbl.BackgroundTransparency=1 slbl.Text="FOV Radius: 120 px"
    slbl.TextColor3=C.text slbl.TextSize=12
    slbl.Font=Enum.Font.GothamBold slbl.TextXAlignment=Enum.TextXAlignment.Left
    slbl.Parent=sliderRow
    local track=Instance.new("Frame")
    track.Size=UDim2.new(1,-24,0,6) track.Position=UDim2.new(0,12,0,32)
    track.BackgroundColor3=C.bg3 track.BorderSizePixel=0 track.Parent=sliderRow
    local trc=Instance.new("UICorner") trc.CornerRadius=UDim.new(1,0) trc.Parent=track
    local fill=Instance.new("Frame")
    fill.Size=UDim2.new(0.4,0,1,0) fill.BackgroundColor3=C.neon
    fill.BorderSizePixel=0 fill.Parent=track
    local frc=Instance.new("UICorner") frc.CornerRadius=UDim.new(1,0) frc.Parent=fill
    local thumb=Instance.new("TextButton")
    thumb.Size=UDim2.new(0,14,0,14) thumb.AnchorPoint=Vector2.new(0.5,0.5)
    thumb.Position=UDim2.new(0.4,0,0.5,0)
    thumb.BackgroundColor3=C.neonGlow thumb.Text="" thumb.BorderSizePixel=0
    thumb.Parent=track
    local tbc2=Instance.new("UICorner") tbc2.CornerRadius=UDim.new(1,0) tbc2.Parent=thumb
    -- FOV range: 40 - 300
    local minFOV,maxFOV=40,300
    local function updateFOV(pct)
        pct=math.clamp(pct,0,1)
        silentAimFOV=math.floor(minFOV+(maxFOV-minFOV)*pct)
        fill.Size=UDim2.new(pct,0,1,0)
        thumb.Position=UDim2.new(pct,0,0.5,0)
        slbl.Text="FOV Radius: "..silentAimFOV.." px"
    end
    local dragging=false
    local function onInput(x)
        local abs=track.AbsolutePosition.X
        local w=track.AbsoluteSize.X
        updateFOV((x-abs)/w)
    end
    thumb.MouseButton1Down:Connect(function() dragging=true end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
            onInput(i.Position.X)
        end
        if dragging and i.UserInputType==Enum.UserInputType.Touch then
            onInput(i.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=false
        end
    end)
    -- Mobile touch on track
    track.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch then
            dragging=true onInput(i.Position.X)
        end
    end)
    updateFOV(0.4)
end

local infAmmoOn=false
createToggle("Combat","Infinite Ammo","Ammo tidak habis",function(s) infAmmoOn=s end)

local noRecoilOn=false
createToggle("Combat","No Recoil","Senjata tidak goyang",function(s) noRecoilOn=s end)

local noSpreadOn=false
createToggle("Combat","No Spread","Peluru tidak menyebar",function(s) noSpreadOn=s end)

createSection("Combat","HITBOX")

local hitboxOn=false
createToggle("Combat","Hitbox Expander","Perbesar hitbox player lain",function(s) hitboxOn=s end)

-- Kill Aura
local killAuraOn=false
local killAuraRadius=20
createToggle("Combat","Kill Aura","Auto hit player dalam radius",function(s) killAuraOn=s end)

-- Auto Parry / Block
local autoParryOn=false
createToggle("Combat","Auto Parry","Auto block saat HP berkurang",function(s) autoParryOn=s end)
local lastHp=100
task.spawn(function()
    while task.wait(0.05) do
        if autoParryOn and Character then
            local hum=Character:FindFirstChildOfClass("Humanoid")
            if hum then
                if hum.Health < lastHp then
                    -- Trigger block: cari tool dan simulasikan secondary activate
                    local tool=Character:FindFirstChildOfClass("Tool")
                    if tool then
                        local ok=pcall(function()
                            if tool:FindFirstChild("RemoteEvent") then
                                tool.RemoteEvent:FireServer("block",true)
                            end
                        end)
                        -- Fallback: set HumanoidStateType
                        if not ok then
                            hum:ChangeState(Enum.HumanoidStateType.Running)
                        end
                    end
                end
                lastHp=hum.Health
            end
        end
    end
end)

-- Combat logic loop
RunService.Heartbeat:Connect(function()
    if not Character then return end
    local hum=Character:FindFirstChildOfClass("Humanoid")
    if godOn and hum then hum.Health=hum.MaxHealth end
    if _G.AntiRagdoll then
        for _,v in ipairs(Character:GetDescendants()) do
            if v:IsA("BallSocketConstraint") or v:IsA("HingeConstraint") then v.Enabled=false end
            if v.Name:lower():find("ragdoll") and v:IsA("BoolValue") then v.Value=false end
        end
    end
    if _G.InfStamina then
        for _,v in ipairs(Character:GetDescendants()) do
            if (v.Name:lower():find("stam") or v.Name:lower():find("ener")) and (v:IsA("NumberValue") or v:IsA("IntValue")) then
                v.Value=100
            end
        end
    end
    -- Gun mods
    local tool=Character:FindFirstChildOfClass("Tool")
    if tool then
        for _,v in ipairs(tool:GetDescendants()) do
            if v:IsA("ValueBase") then
                local n=v.Name:lower()
                if infAmmoOn and (n:find("ammo") or n:find("clip") or n:find("bullet") or n:find("mag")) then v.Value=999 end
                if (noRecoilOn or combatTestEnabled.RecoilTest) and (n:find("recoil") or n:find("kick")) then v.Value=0 end
                if (noSpreadOn or combatTestEnabled.SpreadTest) and (n:find("spread") or n:find("accuracy")) then v.Value=0 end
            end
        end
    end
    -- Kill Aura
    if killAuraOn then
        local root=Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LocalPlayer and p.Character then
                    local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                    local hum=p.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health>0 then
                        local dist=(hrp.Position-root.Position).Magnitude
                        if dist<=killAuraRadius then
                            pcall(function() hum:TakeDamage(10) end)
                            -- Coba tool juga
                            local tool=Character:FindFirstChildOfClass("Tool")
                            if tool and tool:FindFirstChild("Handle") then
                                pcall(function()
                                    tool:Activate()
                                end)
                            end
                        end
                    end
                end
            end
        end
    end

    -- Hitbox
    local hitboxActive = hitboxOn or combatTestEnabled.HitboxTest
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character then
            local head=p.Character:FindFirstChild("Head")
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            if head then
                head.Size=hitboxActive and Vector3.new(8,8,8) or Vector3.new(1.2,1.2,1.2)
                head.Transparency=hitboxActive and 0.7 or 0
                head.CanCollide=false
            end
            if hrp then
                hrp.Size=hitboxActive and Vector3.new(8,8,8) or Vector3.new(2,2,1)
                hrp.Transparency=1 hrp.CanCollide=false
            end
        end
    end
end)

-- Silent aim hook (PC + Mobile)
-- Logic utama ada di metatable hook / RenderStepped di atas
-- hookTool hanya handle snap saat Activated jika metatable tidak tersedia
local function hookTool(tool)
    -- PC: hook Activated
    tool.Activated:Connect(function()
        if not silentAimOn then return end
        local t = silentAimTarget or getClosestTarget()
        if t and Camera then
            local cf = Camera.CFrame
            Camera.CFrame = CFrame.lookAt(cf.Position, t.Position)
        end
    end)
    -- Mobile: hook TouchTap pada tool handle jika ada
    if isMobile then
        local handle = tool:FindFirstChild("Handle")
        if handle then
            handle.Touched:Connect(function() end) -- dummy to ensure it loads
        end
    end
end

if Character then
    local t=Character:FindFirstChildOfClass("Tool")
    if t then hookTool(t) end
    Character.ChildAdded:Connect(function(c) if c:IsA("Tool") then hookTool(c) end end)
end

-- ================================================
-- TAB: VISUAL
-- ================================================
createSection("Visual","ESP")

local espOn=false
local espObjects={}

local function addESP(player)
    if player==LocalPlayer then return end
    local char=player.Character
    if not char or espObjects[player] then return end
    local hrp=char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hl=Instance.new("Highlight")
    hl.FillColor=C.neon hl.FillTransparency=0.75
    hl.OutlineColor=C.neonGlow hl.OutlineTransparency=0
    hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent=char
    local bb=Instance.new("BillboardGui")
    bb.Size=UDim2.new(0,140,0,38) bb.StudsOffset=Vector3.new(0,3,0)
    bb.AlwaysOnTop=true bb.Adornee=hrp bb.Parent=hrp
    local nl=Instance.new("TextLabel")
    nl.Size=UDim2.new(1,0,0.55,0) nl.BackgroundTransparency=1
    nl.Text=player.Name nl.TextColor3=C.neonGlow
    nl.TextStrokeTransparency=0 nl.Font=Enum.Font.GothamBold nl.TextSize=13
    nl.Parent=bb
    local dl=Instance.new("TextLabel")
    dl.Name="Dist" dl.Size=UDim2.new(1,0,0.45,0)
    dl.Position=UDim2.new(0,0,0.55,0) dl.BackgroundTransparency=1
    dl.Text="-- studs" dl.TextColor3=C.text
    dl.TextStrokeTransparency=0 dl.Font=Enum.Font.Gotham dl.TextSize=11
    dl.Parent=bb
    espObjects[player]={hl=hl,bb=bb,dl=dl}
end

local function removeESP(p)
    local o=espObjects[p]
    if o then
        if o.hl then o.hl:Destroy() end
        if o.bb then o.bb:Destroy() end
        espObjects[p]=nil
    end
end

createToggle("Visual","ESP Players","Lihat player tembus tembok",function(s)
    espOn=s
    if s then for _,p in ipairs(Players:GetPlayers()) do addESP(p) end
    else for p in pairs(espObjects) do removeESP(p) end end
end)

-- Chams
local chamsOn=false
local chamsObjects={}
createToggle("Visual","Chams","Warna solid player lain",function(s)
    chamsOn=s
    if not s then
        for _,hl in pairs(chamsObjects) do if hl then hl:Destroy() end end
        chamsObjects={}
    end
end)

-- Tracer ESP
local tracerOn=false
local tracerLines={}
createToggle("Visual","Tracer ESP","Garis dari layar ke player",function(s)
    tracerOn=s
    if not s then
        for _,ln in pairs(tracerLines) do if ln then ln:Remove() end end
        tracerLines={}
    end
end)

-- ESP Items
local espItemOn=false
local espItemObjects={}
createToggle("Visual","ESP Items","Highlight money & item",function(s)
    espItemOn=s
    if not s then
        for _,hl in pairs(espItemObjects) do if hl then hl:Destroy() end end
        espItemObjects={}
    end
end)

createSection("Visual","LIGHTING")

createToggle("Visual","Fullbright","Map jadi terang semua",function(s)
    if s then
        Lighting.Brightness=2 Lighting.ClockTime=14
        Lighting.FogEnd=100000 Lighting.GlobalShadows=false
    else
        Lighting.Brightness=originalLighting.Brightness
        Lighting.ClockTime=originalLighting.ClockTime
        Lighting.FogEnd=originalLighting.FogEnd
        Lighting.GlobalShadows=originalLighting.GlobalShadows
    end
end)

createToggle("Visual","No Fog","Hilangkan kabut map",function(s)
    if s then Lighting.FogEnd=100000 Lighting.FogStart=99999
    else Lighting.FogEnd=originalLighting.FogEnd Lighting.FogStart=originalLighting.FogStart end
end)

createToggle("Visual","FPS Booster","Matikan efek berat",function(s)
    Lighting.GlobalShadows=not s
    settings().Rendering.QualityLevel=s and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Smoke") or o:IsA("Fire") then
            o.Enabled=not s
        end
    end
end)

-- Crosshair custom (Drawing API)
local crosshairOn=false
local crosshairLines={}
local function buildCrosshair()
    for _,l in ipairs(crosshairLines) do pcall(function() l:Remove() end) end
    crosshairLines={}
    pcall(function()
        local vp=Camera.ViewportSize
        local cx,cy=vp.X/2,vp.Y/2
        local gap,len,thick=6,8,1.5
        local dirs={{Vector2.new(-gap-len,0),Vector2.new(-gap,0)},{Vector2.new(gap,0),Vector2.new(gap+len,0)},{Vector2.new(0,-gap-len),Vector2.new(0,-gap)},{Vector2.new(0,gap),Vector2.new(0,gap+len)}}
        for _,d in ipairs(dirs) do
            local l=Drawing.new("Line")
            l.From=Vector2.new(cx+d[1].X,cy+d[1].Y)
            l.To=Vector2.new(cx+d[2].X,cy+d[2].Y)
            l.Color=C.neonGlow l.Thickness=thick l.Transparency=0 l.Visible=true
            table.insert(crosshairLines,l)
        end
        -- dot tengah
        local dot=Drawing.new("Circle")
        dot.Position=Vector2.new(cx,cy) dot.Radius=1.5
        dot.Color=C.neonGlow dot.Filled=true dot.Thickness=1 dot.Visible=true
        table.insert(crosshairLines,dot)
    end)
end
createToggle("Visual","Custom Crosshair","Dot+cross via Drawing API",function(s)
    crosshairOn=s
    if s then buildCrosshair()
    else for _,l in ipairs(crosshairLines) do pcall(function() l:Remove() end) end crosshairLines={} end
end)

-- Radar mini-map (Drawing API)
local radarOn=false
local radarDots={}
local radarFrame -- Drawing circle background
createToggle("Visual","Radar Mini-Map","Posisi player di sudut layar",function(s)
    radarOn=s
    if not s then
        for _,d in pairs(radarDots) do pcall(function() for _,v in pairs(d) do v:Remove() end end) end
        radarDots={}
        if radarFrame then pcall(function() radarFrame:Remove() end) radarFrame=nil end
    else
        pcall(function()
            radarFrame=Drawing.new("Circle")
            radarFrame.Position=Vector2.new(Camera.ViewportSize.X-90,Camera.ViewportSize.Y-90)
            radarFrame.Radius=70 radarFrame.Color=Color3.fromRGB(10,8,20)
            radarFrame.Filled=true radarFrame.Transparency=0.4 radarFrame.Thickness=1.5
            radarFrame.Visible=true
        end)
    end
end)

-- Visual update loop
RunService.RenderStepped:Connect(function()
    -- ESP distance + health color update
    if espOn and RootPart and RootPart.Parent then
        for player,obj in pairs(espObjects) do
            local char=player.Character
            local hrp=char and char:FindFirstChild("HumanoidRootPart")
            local hum=char and char:FindFirstChildOfClass("Humanoid")
            if hrp and obj.dl then
                obj.dl.Text=math.floor((hrp.Position-RootPart.Position).Magnitude).." studs"
            end
            -- Warna nama berdasarkan health
            if hum and obj.hl then
                local hp=hum.Health/hum.MaxHealth
                local r=math.floor(255*(1-hp)) local g=math.floor(255*hp)
                if obj.hl then obj.hl.OutlineColor=Color3.fromRGB(r,g,0) end
            end
        end
    end

    -- Radar update
    if radarOn and RootPart and RootPart.Parent then
        local vp=Camera.ViewportSize
        local cx,cy=vp.X-90,vp.Y-90
        local radarRadius=65
        local worldRadius=200
        -- clear old dots
        for _,d in pairs(radarDots) do pcall(function() for _,v in pairs(d) do v:Remove() end end) end
        radarDots={}
        pcall(function()
            if radarFrame then radarFrame.Position=Vector2.new(cx,cy) end
            local myPos=RootPart.Position
            local myCF=RootPart.CFrame
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LocalPlayer and p.Character then
                    local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local rel=myCF:PointToObjectSpace(hrp.Position)
                        local rx=math.clamp(rel.X/worldRadius,-1,1)*radarRadius
                        local ry=math.clamp(-rel.Z/worldRadius,-1,1)*radarRadius
                        local dot=Drawing.new("Circle")
                        dot.Position=Vector2.new(cx+rx,cy+ry)
                        dot.Radius=4 dot.Color=C.neon
                        dot.Filled=true dot.Thickness=1 dot.Visible=true
                        local lbl=Drawing.new("Text")
                        lbl.Position=Vector2.new(cx+rx+5,cy+ry-5)
                        lbl.Text=p.Name:sub(1,6) lbl.Size=10
                        lbl.Color=C.text lbl.Visible=true
                        radarDots[p]={dot,lbl}
                    end
                end
            end
        end)
    end

    -- Chams
    if chamsOn then
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character and not chamsObjects[p] then
                local hl=Instance.new("Highlight")
                hl.FillColor=Color3.fromRGB(255,50,50)
                hl.FillTransparency=0
                hl.OutlineColor=C.white
                hl.OutlineTransparency=0.5
                hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
                hl.Parent=p.Character
                chamsObjects[p]=hl
            end
        end
    end

    -- Tracer (pakai Drawing API kalau tersedia)
    if tracerOn then
        for _,ln in pairs(tracerLines) do if ln then pcall(function() ln:Remove() end) end end
        tracerLines={}
        local vp=Camera.ViewportSize
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character then
                local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local pos,vis=Camera:WorldToViewportPoint(hrp.Position)
                    if vis then
                        local ok,ln=pcall(function()
                            local l=Drawing.new("Line")
                            l.From=Vector2.new(vp.X/2,vp.Y)
                            l.To=Vector2.new(pos.X,pos.Y)
                            l.Color=C.neon l.Thickness=1.5 l.Transparency=0.6
                            l.Visible=true
                            return l
                        end)
                        if ok then table.insert(tracerLines,ln) end
                    end
                end
            end
        end
    end

    -- ESP Items
    if espItemOn then
        for _,obj in ipairs(workspace:GetDescendants()) do
            local n=obj.Name:lower()
            if obj:IsA("BasePart") and (n:find("money") or n:find("cash") or n:find("drop") or n:find("item")) and not espItemObjects[obj] then
                local hl=Instance.new("Highlight")
                hl.FillColor=Color3.fromRGB(250,204,21)
                hl.OutlineColor=C.white hl.FillTransparency=0.5
                hl.Parent=obj espItemObjects[obj]=hl
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if espOn then task.wait(0.5) removeESP(p) addESP(p) end
        if chamsOn then chamsObjects[p]=nil end
    end)
end)
Players.PlayerRemoving:Connect(function(p)
    removeESP(p)
    if chamsObjects[p] then chamsObjects[p]:Destroy() chamsObjects[p]=nil end
end)

-- ================================================
-- TAB: UTILITY
-- ================================================
createSection("Utility","TELEPORT")

-- Teleport ke player
local TpFrame=Instance.new("Frame")
TpFrame.Size=UDim2.new(1,0,0,42) TpFrame.BackgroundColor3=C.bg2
TpFrame.BorderSizePixel=0 TpFrame.Parent=TabPages["Utility"]
local TpFC=Instance.new("UICorner") TpFC.CornerRadius=UDim.new(0,10) TpFC.Parent=TpFrame
local TpFS=Instance.new("UIStroke") TpFS.Color=C.neonDim TpFS.Thickness=0.8 TpFS.Parent=TpFrame
local TpBox=Instance.new("TextBox")
TpBox.Size=UDim2.new(0.58,-8,1,-12) TpBox.Position=UDim2.new(0,8,0,6)
TpBox.BackgroundColor3=C.bg TpBox.Text="" TpBox.PlaceholderText="Nama player..."
TpBox.TextColor3=C.text TpBox.PlaceholderColor3=C.textDim
TpBox.TextSize=12 TpBox.Font=Enum.Font.Gotham
TpBox.BorderSizePixel=0 TpBox.ClearTextOnFocus=false TpBox.Parent=TpFrame
local TpBC=Instance.new("UICorner") TpBC.CornerRadius=UDim.new(0,6) TpBC.Parent=TpBox
local TpBtn=Instance.new("TextButton")
TpBtn.Size=UDim2.new(0.42,-8,1,-12) TpBtn.Position=UDim2.new(0.58,4,0,6)
TpBtn.BackgroundColor3=C.neonDim TpBtn.Text="➜ Teleport"
TpBtn.TextColor3=C.neonGlow TpBtn.TextSize=12
TpBtn.Font=Enum.Font.GothamBold TpBtn.BorderSizePixel=0 TpBtn.Parent=TpFrame
local TpBtnC=Instance.new("UICorner") TpBtnC.CornerRadius=UDim.new(0,6) TpBtnC.Parent=TpBtn
TpBtn.MouseButton1Click:Connect(function()
    local name=TpBox.Text:lower()
    if name=="" then return end
    for _,p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(name) and p~=LocalPlayer then
            local hrp=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if hrp and RootPart then RootPart.CFrame=hrp.CFrame+Vector3.new(0,3,0) end
            break
        end
    end
end)

-- Spectate player
createSection("Utility","SPECTATE")
local SpectateFrame=Instance.new("Frame")
SpectateFrame.Size=UDim2.new(1,0,0,42) SpectateFrame.BackgroundColor3=C.bg2
SpectateFrame.BorderSizePixel=0 SpectateFrame.Parent=TabPages["Utility"]
local SFC=Instance.new("UICorner") SFC.CornerRadius=UDim.new(0,10) SFC.Parent=SpectateFrame
local SFS=Instance.new("UIStroke") SFS.Color=C.neonDim SFS.Thickness=0.8 SFS.Parent=SpectateFrame
local SpectateBox=Instance.new("TextBox")
SpectateBox.Size=UDim2.new(0.58,-8,1,-12) SpectateBox.Position=UDim2.new(0,8,0,6)
SpectateBox.BackgroundColor3=C.bg SpectateBox.Text="" SpectateBox.PlaceholderText="Nama player..."
SpectateBox.TextColor3=C.text SpectateBox.PlaceholderColor3=C.textDim
SpectateBox.TextSize=12 SpectateBox.Font=Enum.Font.Gotham
SpectateBox.BorderSizePixel=0 SpectateBox.ClearTextOnFocus=false SpectateBox.Parent=SpectateFrame
local SBC=Instance.new("UICorner") SBC.CornerRadius=UDim.new(0,6) SBC.Parent=SpectateBox
local SpectateBtn=Instance.new("TextButton")
SpectateBtn.Size=UDim2.new(0.42,-8,1,-12) SpectateBtn.Position=UDim2.new(0.58,4,0,6)
SpectateBtn.BackgroundColor3=C.neonDim SpectateBtn.Text="👁 Spectate"
SpectateBtn.TextColor3=C.neonGlow SpectateBtn.TextSize=12
SpectateBtn.Font=Enum.Font.GothamBold SpectateBtn.BorderSizePixel=0 SpectateBtn.Parent=SpectateFrame
local SBtnC=Instance.new("UICorner") SBtnC.CornerRadius=UDim.new(0,6) SBtnC.Parent=SpectateBtn

local spectating=false
SpectateBtn.MouseButton1Click:Connect(function()
    local name=SpectateBox.Text:lower()
    if name=="" then
        -- Stop spectate
        Camera.CameraType=Enum.CameraType.Custom
        Camera.CameraSubject=Character and Character:FindFirstChildOfClass("Humanoid")
        spectating=false SpectateBtn.Text="👁 Spectate"
        showToast("Spectate","false") return
    end
    for _,p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(name) and p~=LocalPlayer then
            local hum=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                Camera.CameraType=Enum.CameraType.Custom
                Camera.CameraSubject=hum
                spectating=true
                SpectateBtn.Text="⛔ Stop"
                showToast("Spectate "..p.Name,true)
            end
            break
        end
    end
end)

-- Waypoint
createSection("Utility","WAYPOINT")
local WpFrame=Instance.new("Frame")
WpFrame.Size=UDim2.new(1,0,0,42) WpFrame.BackgroundColor3=C.bg2
WpFrame.BorderSizePixel=0 WpFrame.Parent=TabPages["Utility"]
local WFC=Instance.new("UICorner") WFC.CornerRadius=UDim.new(0,10) WFC.Parent=WpFrame
local WFS=Instance.new("UIStroke") WFS.Color=C.neonDim WFS.Thickness=0.8 WFS.Parent=WpFrame
local WpBox=Instance.new("TextBox")
WpBox.Size=UDim2.new(0.58,-8,1,-12) WpBox.Position=UDim2.new(0,8,0,6)
WpBox.BackgroundColor3=C.bg WpBox.Text="" WpBox.PlaceholderText="Nama waypoint..."
WpBox.TextColor3=C.text WpBox.PlaceholderColor3=C.textDim
WpBox.TextSize=12 WpBox.Font=Enum.Font.Gotham
WpBox.BorderSizePixel=0 WpBox.ClearTextOnFocus=false WpBox.Parent=WpFrame
local WBC2=Instance.new("UICorner") WBC2.CornerRadius=UDim.new(0,6) WBC2.Parent=WpBox
local WpSaveBtn=Instance.new("TextButton")
WpSaveBtn.Size=UDim2.new(0.42,-8,1,-12) WpSaveBtn.Position=UDim2.new(0.58,4,0,6)
WpSaveBtn.BackgroundColor3=C.neonDim WpSaveBtn.Text="💾 Simpan"
WpSaveBtn.TextColor3=C.neonGlow WpSaveBtn.TextSize=12
WpSaveBtn.Font=Enum.Font.GothamBold WpSaveBtn.BorderSizePixel=0 WpSaveBtn.Parent=WpFrame
local WSC2=Instance.new("UICorner") WSC2.CornerRadius=UDim.new(0,6) WSC2.Parent=WpSaveBtn

local wpCount=0
local function addWpRow(name,cf)
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,0,0,36) row.BackgroundColor3=C.bg3
    row.BorderSizePixel=0 row.Parent=TabPages["Utility"]
    local rc=Instance.new("UICorner") rc.CornerRadius=UDim.new(0,8) rc.Parent=row
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(0.5,-4,1,0) lbl.Position=UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency=1 lbl.Text="📍 "..name
    lbl.TextColor3=C.text lbl.TextSize=11
    lbl.Font=Enum.Font.Gotham lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.TextTruncate=Enum.TextTruncate.AtEnd lbl.Parent=row
    local go=Instance.new("TextButton")
    go.Size=UDim2.new(0.26,-4,0,26) go.Position=UDim2.new(0.5,4,0.5,-13)
    go.BackgroundColor3=Color3.fromRGB(21,128,61) go.Text="Go"
    go.TextColor3=C.white go.TextSize=11
    go.Font=Enum.Font.GothamBold go.BorderSizePixel=0 go.Parent=row
    local gc=Instance.new("UICorner") gc.CornerRadius=UDim.new(0,6) gc.Parent=go
    local del=Instance.new("TextButton")
    del.Size=UDim2.new(0.24,-4,0,26) del.Position=UDim2.new(0.76,0,0.5,-13)
    del.BackgroundColor3=Color3.fromRGB(153,27,27) del.Text="✕"
    del.TextColor3=C.white del.TextSize=11
    del.Font=Enum.Font.GothamBold del.BorderSizePixel=0 del.Parent=row
    local dc2=Instance.new("UICorner") dc2.CornerRadius=UDim.new(0,6) dc2.Parent=del
    go.MouseButton1Click:Connect(function() if RootPart and RootPart.Parent then RootPart.CFrame=cf end end)
    del.MouseButton1Click:Connect(function() row:Destroy() end)
end

WpSaveBtn.MouseButton1Click:Connect(function()
    if not RootPart or not RootPart.Parent then return end
    wpCount=wpCount+1
    local name=WpBox.Text~="" and WpBox.Text or ("WP "..wpCount)
    addWpRow(name,RootPart.CFrame)
    WpBox.Text=""
    showToast("Waypoint '"..name.."' disimpan",true)
end)

createSection("Utility","MISC")

createToggle("Utility","Anti AFK","Cegah kick saat idle",function(s) _G.AntiAFK=s end)
_G.AntiAFK=false
LocalPlayer.Idled:Connect(function()
    if _G.AntiAFK then VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end
end)

createToggle("Utility","Auto Collect","Vacuum money & item terdekat",function(s) _G.AutoCollect=s end)
_G.AutoCollect=false
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoCollect then
            local root=Character and Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _,obj in ipairs(workspace:GetDescendants()) do
                    local n=obj.Name:lower()
                    if obj:IsA("BasePart") and (n:find("money") or n:find("cash") or n:find("drop")) then
                        if (obj.Position-root.Position).Magnitude<=30 then obj.CFrame=root.CFrame end
                    end
                end
            end
        end
    end
end)

-- Loop Teleport
createSection("Utility","LOOP TELEPORT")
local loopTpFrame=Instance.new("Frame")
loopTpFrame.Size=UDim2.new(1,0,0,42) loopTpFrame.BackgroundColor3=C.bg2
loopTpFrame.BorderSizePixel=0 loopTpFrame.Parent=TabPages["Utility"]
local lFC=Instance.new("UICorner") lFC.CornerRadius=UDim.new(0,10) lFC.Parent=loopTpFrame
local lFS=Instance.new("UIStroke") lFS.Color=C.neonDim lFS.Thickness=0.8 lFS.Parent=loopTpFrame
local loopTpBox=Instance.new("TextBox")
loopTpBox.Size=UDim2.new(0.58,-8,1,-12) loopTpBox.Position=UDim2.new(0,8,0,6)
loopTpBox.BackgroundColor3=C.bg loopTpBox.Text="" loopTpBox.PlaceholderText="Nama player..."
loopTpBox.TextColor3=C.text loopTpBox.PlaceholderColor3=C.textDim
loopTpBox.TextSize=12 loopTpBox.Font=Enum.Font.Gotham
loopTpBox.BorderSizePixel=0 loopTpBox.ClearTextOnFocus=false loopTpBox.Parent=loopTpFrame
local lBC=Instance.new("UICorner") lBC.CornerRadius=UDim.new(0,6) lBC.Parent=loopTpBox
createToggle("Utility","Loop TP","Teleport terus ke target",function(s)
    _G.LoopTpOn=s
end)
_G.LoopTpOn=false
task.spawn(function()
    while task.wait(0.3) do
        if _G.LoopTpOn then
            local name=loopTpBox.Text:lower()
            if name~="" then
                for _,p in ipairs(Players:GetPlayers()) do
                    if p.Name:lower():find(name) and p~=LocalPlayer then
                        local hrp=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                        local rp=Character and Character:FindFirstChild("HumanoidRootPart")
                        if hrp and rp then rp.CFrame=hrp.CFrame+Vector3.new(0,3,0) end
                        break
                    end
                end
            end
        end
    end
end)

-- Chat Spammer
createSection("Utility","CHAT SPAMMER")
local chatFrame=Instance.new("Frame")
chatFrame.Size=UDim2.new(1,0,0,42) chatFrame.BackgroundColor3=C.bg2
chatFrame.BorderSizePixel=0 chatFrame.Parent=TabPages["Utility"]
local cFC2=Instance.new("UICorner") cFC2.CornerRadius=UDim.new(0,10) cFC2.Parent=chatFrame
local cFS2=Instance.new("UIStroke") cFS2.Color=C.neonDim cFS2.Thickness=0.8 cFS2.Parent=chatFrame
local chatMsgBox=Instance.new("TextBox")
chatMsgBox.Size=UDim2.new(1,-16,1,-12) chatMsgBox.Position=UDim2.new(0,8,0,6)
chatMsgBox.BackgroundColor3=C.bg chatMsgBox.Text="" chatMsgBox.PlaceholderText="Pesan spam..."
chatMsgBox.TextColor3=C.text chatMsgBox.PlaceholderColor3=C.textDim
chatMsgBox.TextSize=12 chatMsgBox.Font=Enum.Font.Gotham
chatMsgBox.BorderSizePixel=0 chatMsgBox.ClearTextOnFocus=false chatMsgBox.Parent=chatFrame
local cBC2=Instance.new("UICorner") cBC2.CornerRadius=UDim.new(0,6) cBC2.Parent=chatMsgBox
createToggle("Utility","Chat Spam","Kirim pesan otomatis tiap 2 detik",function(s) _G.ChatSpam=s end)
_G.ChatSpam=false
task.spawn(function()
    while task.wait(2) do
        if _G.ChatSpam and chatMsgBox.Text~="" then
            pcall(function()
                game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
                    :FindFirstChild("SayMessageRequest"):FireServer(chatMsgBox.Text,"All")
            end)
        end
    end
end)

-- Server Hop
createSection("Utility","SERVER HOP")
local SHBtn=Instance.new("TextButton")
SHBtn.Size=UDim2.new(1,0,0,32) SHBtn.BackgroundColor3=C.bg3
SHBtn.Text="🔀 Server Hop (Rejoin Random)" SHBtn.TextColor3=C.neonGlow
SHBtn.TextSize=11 SHBtn.Font=Enum.Font.GothamBold SHBtn.BorderSizePixel=0
SHBtn.Parent=TabPages["Utility"]
local SHBC=Instance.new("UICorner") SHBC.CornerRadius=UDim.new(0,8) SHBC.Parent=SHBtn
SHBtn.MouseButton1Click:Connect(function()
    showToast("Server Hopping...",true)
    task.wait(0.5)
    pcall(function()
        local TS=game:GetService("TeleportService")
        local servers={}
        local ok,pages=pcall(function()
            return TS:GetPlayerPlaceInstancesAsync(game.PlaceId)
        end)
        if ok and pages then
            for _,s in ipairs(pages:GetCurrentPage()) do
                if s.CurrentPlayers < s.MaxPlayers then
                    table.insert(servers,s)
                end
            end
            if #servers>0 then
                local pick=servers[math.random(1,#servers)]
                TS:TeleportToPlaceInstance(game.PlaceId,pick.JobId,LocalPlayer)
            else
                -- Fallback: rejoin same game
                TS:Teleport(game.PlaceId,LocalPlayer)
            end
        else
            TS:Teleport(game.PlaceId,LocalPlayer)
        end
    end)
end)

-- ================================================
-- TAB: EXTRA (Player List, Chat Logger, Theme, Keybind)
-- ================================================
createSection("Extra","PLAYER LIST")

local PlayerListFrame=Instance.new("Frame")
PlayerListFrame.Size=UDim2.new(1,0,0,0)
PlayerListFrame.AutomaticSize=Enum.AutomaticSize.Y
PlayerListFrame.BackgroundColor3=C.bg2
PlayerListFrame.BorderSizePixel=0
PlayerListFrame.Parent=TabPages["Extra"]
local PLFC=Instance.new("UICorner") PLFC.CornerRadius=UDim.new(0,10) PLFC.Parent=PlayerListFrame
local PLFL=Instance.new("UIListLayout") PLFL.Padding=UDim.new(0,2) PLFL.Parent=PlayerListFrame
local PLFPad=Instance.new("UIPadding") PLFPad.PaddingTop=UDim.new(0,6) PLFPad.PaddingBottom=UDim.new(0,6) PLFPad.Parent=PlayerListFrame

local PlayerSearch=Instance.new("TextBox")
PlayerSearch.Size=UDim2.new(1,0,0,32)
PlayerSearch.BackgroundColor3=C.bg2
PlayerSearch.Text=""
PlayerSearch.PlaceholderText="🔎 Search player..."
PlayerSearch.TextColor3=C.text
PlayerSearch.PlaceholderColor3=C.textDim
PlayerSearch.TextSize=11
PlayerSearch.Font=Enum.Font.Gotham
PlayerSearch.BorderSizePixel=0
PlayerSearch.ClearTextOnFocus=false
PlayerSearch.Parent=TabPages["Extra"]
local PSC=Instance.new("UICorner") PSC.CornerRadius=UDim.new(0,8) PSC.Parent=PlayerSearch

local playerRows={}
local function refreshPlayerList()

    for _,row in pairs(playerRows) do row:Destroy() end
    playerRows={}
    local query=PlayerSearch.Text:lower()
    for _,p in ipairs(Players:GetPlayers()) do
        if query=="" or p.Name:lower():find(query,1,true) or p.DisplayName:lower():find(query,1,true) then
        local row=Instance.new("Frame")
        row.Size=UDim2.new(1,0,0,28)
        row.BackgroundTransparency=1
        row.Parent=PlayerListFrame
        local dot=Instance.new("Frame")
        dot.Size=UDim2.new(0,6,0,6) dot.Position=UDim2.new(0,10,0.5,-3)
        dot.BackgroundColor3=p==LocalPlayer and C.green or C.neon
        dot.BorderSizePixel=0 dot.Parent=row
        local dc=Instance.new("UICorner") dc.CornerRadius=UDim.new(1,0) dc.Parent=dot
        local nl=Instance.new("TextLabel")
        nl.Size=UDim2.new(0.7,0,1,0) nl.Position=UDim2.new(0,22,0,0)
        nl.BackgroundTransparency=1
        nl.Text=(p==LocalPlayer and "[You] " or "")..p.DisplayName.."  @"..p.Name
        nl.TextColor3=p==LocalPlayer and C.green or C.text
        nl.TextSize=11 nl.Font=Enum.Font.Gotham
        nl.TextXAlignment=Enum.TextXAlignment.Left nl.Parent=row
        local dl=Instance.new("TextLabel")
        dl.Name="Dist_"..p.UserId
        dl.Size=UDim2.new(0.3,0,1,0) dl.Position=UDim2.new(0.7,0,0,0)
        dl.BackgroundTransparency=1 dl.Text="--"
        dl.TextColor3=C.textDim dl.TextSize=11
        dl.Font=Enum.Font.Gotham dl.TextXAlignment=Enum.TextXAlignment.Right
        dl.Parent=row
        table.insert(playerRows,row)
        end
    end
end
refreshPlayerList()

PlayerSearch:GetPropertyChangedSignal("Text"):Connect(refreshPlayerList)

-- Update jarak player list setiap detik
local plTimer=0
RunService.Heartbeat:Connect(function(dt)
    plTimer=plTimer+dt
    if plTimer<1 then return end plTimer=0
    if not TabPages["Extra"].Visible then return end
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character and RootPart and RootPart.Parent then
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist=math.floor((hrp.Position-RootPart.Position).Magnitude)
                local dl=PlayerListFrame:FindFirstChild("Dist_"..p.UserId,true)
                if dl then dl.Text=dist.." st" end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function() refreshPlayerList() end)
Players.PlayerRemoving:Connect(function() task.wait(0.1) refreshPlayerList() end)

-- Refresh button
local RefreshBtn=Instance.new("TextButton")
RefreshBtn.Size=UDim2.new(1,0,0,28)
RefreshBtn.BackgroundColor3=C.bg3 RefreshBtn.Text="🔄 Refresh List"
RefreshBtn.TextColor3=C.neonGlow RefreshBtn.TextSize=11
RefreshBtn.Font=Enum.Font.GothamBold RefreshBtn.BorderSizePixel=0
RefreshBtn.Parent=TabPages["Extra"]
local RBC=Instance.new("UICorner") RBC.CornerRadius=UDim.new(0,8) RBC.Parent=RefreshBtn
RefreshBtn.MouseButton1Click:Connect(refreshPlayerList)

createSection("Extra","CHAT LOGGER")

local ChatFrame=Instance.new("ScrollingFrame")
ChatFrame.Size=UDim2.new(1,0,0,120)
ChatFrame.BackgroundColor3=C.bg2 ChatFrame.BorderSizePixel=0
ChatFrame.ScrollBarThickness=3 ChatFrame.ScrollBarImageColor3=C.neon
ChatFrame.CanvasSize=UDim2.new(0,0,0,0)
ChatFrame.AutomaticCanvasSize=Enum.AutomaticSize.Y
ChatFrame.Parent=TabPages["Extra"]
local CFC=Instance.new("UICorner") CFC.CornerRadius=UDim.new(0,10) CFC.Parent=ChatFrame
local CFL=Instance.new("UIListLayout") CFL.Padding=UDim.new(0,2) CFL.Parent=ChatFrame
local CFPad=Instance.new("UIPadding") CFPad.PaddingAll=UDim.new(0,6) CFPad.Parent=ChatFrame

local function logChat(player, msg)
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,0,0,0)
    lbl.AutomaticSize=Enum.AutomaticSize.Y
    lbl.BackgroundTransparency=1
    lbl.Text="["..player.Name.."]: "..msg
    lbl.TextColor3=player==LocalPlayer and C.green or C.text
    lbl.TextSize=10 lbl.Font=Enum.Font.Gotham
    lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.TextWrapped=true lbl.Parent=ChatFrame
    -- Auto scroll ke bawah
    ChatFrame.CanvasPosition=Vector2.new(0,ChatFrame.AbsoluteCanvasSize.Y)
end

-- Hook chat semua player
local function hookPlayerChat(p)
    p.Chatted:Connect(function(msg) logChat(p,msg) end)
end
for _,p in ipairs(Players:GetPlayers()) do hookPlayerChat(p) end
Players.PlayerAdded:Connect(hookPlayerChat)

createSection("Extra","THEME")

local themeNames={"Purple","Blue","Red","Green"}
local themeColors={
    Purple=Color3.fromRGB(168,85,247),
    Blue=Color3.fromRGB(59,130,246),
    Red=Color3.fromRGB(239,68,68),
    Green=Color3.fromRGB(34,197,94),
}

local ThemeGrid=Instance.new("Frame")
ThemeGrid.Size=UDim2.new(1,0,0,38)
ThemeGrid.BackgroundTransparency=1
ThemeGrid.Parent=TabPages["Extra"]
local TGL=Instance.new("UIListLayout")
TGL.FillDirection=Enum.FillDirection.Horizontal
TGL.Padding=UDim.new(0,6) TGL.Parent=ThemeGrid

for _,name in ipairs(themeNames) do
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(0,68,0,34)
    btn.BackgroundColor3=Themes[name].neonDim
    btn.Text=name btn.TextColor3=Color3.fromRGB(255,255,255)
    btn.TextSize=11 btn.Font=Enum.Font.GothamBold
    btn.BorderSizePixel=0 btn.Parent=ThemeGrid
    local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(0,8) bc.Parent=btn
    local bs=Instance.new("UIStroke") bs.Color=themeColors[name] bs.Thickness=1.5 bs.Parent=btn
    btn.MouseButton1Click:Connect(function()
        applyTheme(name)
        -- Update warna utama UI
        MainFrame.BackgroundColor3=C.bg
        MFS.Color=C.neon
        TitleBar.BackgroundColor3=C.bg2
        TitleLabel.TextColor3=C.neonGlow
        OS.Color=C.neon
        TabBar.BackgroundColor3=C.bg2
        for n,b in pairs(TabBtns) do
            b.TextColor3=(TabPages[n].Visible and C.neonGlow or C.textDim)
            b.BackgroundColor3=(TabPages[n].Visible and C.tabActive or C.tabOff)
        end
        PlayerSearch.BackgroundColor3=C.bg2
        FpsLabel.BackgroundColor3=C.bg2
        showToast("Theme: "..name,true)
    end)
end


local function ThemeBtn(name, color)
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(0,68,0,34)
    btn.BackgroundColor3=Themes[name] and Themes[name].neonDim or color
    btn.Text=name btn.TextColor3=Color3.fromRGB(255,255,255)
    btn.TextSize=11 btn.Font=Enum.Font.GothamBold
    btn.BorderSizePixel=0 btn.Parent=ThemeGrid
    local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(0,8) bc.Parent=btn
    local bs=Instance.new("UIStroke") bs.Color=color bs.Thickness=1.5 bs.Parent=btn
    btn.MouseButton1Click:Connect(function()
        applyTheme(name)
        MainFrame.BackgroundColor3=C.bg
        MFS.Color=C.neon
        TitleBar.BackgroundColor3=C.bg2
        TitleLabel.TextColor3=C.neonGlow
        OS.Color=C.neon
        TabBar.BackgroundColor3=C.bg2
        for n,b in pairs(TabBtns) do
            b.TextColor3=(TabPages[n].Visible and C.neonGlow or C.textDim)
            b.BackgroundColor3=(TabPages[n].Visible and C.tabActive or C.tabOff)
        end
        PlayerSearch.BackgroundColor3=C.bg2
        FpsLabel.BackgroundColor3=C.bg2
        showToast("Theme: "..name,true)
    end)
end

ThemeBtn("Pink", Color3.fromRGB(236,72,153))
ThemeBtn("Gold", Color3.fromRGB(234,179,8))
ThemeBtn("Midnight", Color3.fromRGB(99,102,241))
createSection("Extra","PERFORMANCE")
local FpsLabel=Instance.new("TextLabel")
FpsLabel.Size=UDim2.new(1,0,0,28)
FpsLabel.BackgroundColor3=C.bg2
FpsLabel.Text="FPS: --"
FpsLabel.TextColor3=C.neonGlow
FpsLabel.TextSize=11
FpsLabel.Font=Enum.Font.GothamBold
FpsLabel.BorderSizePixel=0
FpsLabel.Parent=TabPages["Extra"]
local FLC=Instance.new("UICorner") FLC.CornerRadius=UDim.new(0,8) FLC.Parent=FpsLabel

local fpsFrames=0
local fpsElapsed=0
RunService.RenderStepped:Connect(function(dt)
    fpsFrames=fpsFrames+1
    fpsElapsed=fpsElapsed+dt
    if fpsElapsed>=1 then
        FpsLabel.Text="FPS: "..math.floor(fpsFrames/fpsElapsed)
        fpsFrames=0
        fpsElapsed=0
    end
end)

createSection("Extra","KEYBIND (PC)")

local KeybindFrame=Instance.new("Frame")
KeybindFrame.Size=UDim2.new(1,0,0,52)
KeybindFrame.BackgroundColor3=C.bg2 KeybindFrame.BorderSizePixel=0
KeybindFrame.Parent=TabPages["Extra"]
local KFC=Instance.new("UICorner") KFC.CornerRadius=UDim.new(0,10) KFC.Parent=KeybindFrame
local KFS=Instance.new("UIStroke") KFS.Color=C.neonDim KFS.Thickness=0.8 KFS.Parent=KeybindFrame
local KT=Instance.new("TextLabel")
KT.Size=UDim2.new(1,-120,0,20) KT.Position=UDim2.new(0,12,0,6)
KT.BackgroundTransparency=1 KT.Text="Keybind Hide/Show"
KT.TextColor3=C.text KT.TextSize=13
KT.Font=Enum.Font.GothamBold KT.TextXAlignment=Enum.TextXAlignment.Left KT.Parent=KeybindFrame
local KS=Instance.new("TextLabel")
KS.Size=UDim2.new(1,-120,0,14) KS.Position=UDim2.new(0,12,0,28)
KS.BackgroundTransparency=1 KS.Text="PC only"
KS.TextColor3=C.textDim KS.TextSize=11
KS.Font=Enum.Font.Gotham KS.TextXAlignment=Enum.TextXAlignment.Left KS.Parent=KeybindFrame
local KBtn=Instance.new("TextButton")
KBtn.Size=UDim2.new(0,100,0,30) KBtn.Position=UDim2.new(1,-110,0.5,-15)
KBtn.BackgroundColor3=C.neonDim KBtn.Text="RightCtrl"
KBtn.TextColor3=C.neonGlow KBtn.TextSize=11
KBtn.Font=Enum.Font.GothamBold KBtn.BorderSizePixel=0 KBtn.Parent=KeybindFrame
local KBC=Instance.new("UICorner") KBC.CornerRadius=UDim.new(0,6) KBC.Parent=KBtn

local currentKeybind=Enum.KeyCode.RightControl
local listeningKey=false
KBtn.MouseButton1Click:Connect(function()
    if listeningKey then return end
    listeningKey=true KBtn.Text="Tekan..." KBtn.TextColor3=C.green
end)

-- ================================================
-- RESPAWN HANDLER
-- ================================================
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character=newChar
    Humanoid=newChar:WaitForChild("Humanoid")
    RootPart=newChar:WaitForChild("HumanoidRootPart")
    newChar.ChildAdded:Connect(function(c) if c:IsA("Tool") then hookTool(c) end end)
    if chamsOn then chamsObjects={} end
    -- Restart fly jika sedang aktif saat respawn
    if flyOn then
        task.wait(0.5) -- tunggu character fully loaded
        startFly()
    end
end)

-- ================================================
-- INPUT HANDLER
-- ================================================
UserInputService.InputBegan:Connect(function(input,gp)
    if gp then return end
    if listeningKey and input.UserInputType==Enum.UserInputType.Keyboard then
        currentKeybind=input.KeyCode
        listeningKey=false
        KBtn.Text=tostring(input.KeyCode):gsub("Enum.KeyCode.","")
        KBtn.TextColor3=C.neonGlow
        showToast("Keybind diset",true)
        return
    end
    if input.KeyCode==currentKeybind then
        MainFrame.Visible=not MainFrame.Visible
        OpenBtn.Visible=not MainFrame.Visible
    end
end)

-- ================================================
-- CONFIG SAVE / LOAD
-- ================================================
createSection("Extra","CONFIG")

local function saveConfig()
    local cfg={}
    for k,v in pairs(_G.VeronConfig) do cfg[k]=v end
    local str=""
    for k,v in pairs(cfg) do
        str=str..tostring(k).."="..tostring(v).."\n"
    end
    pcall(function() writefile("VeronConfig.txt",str) end)
    showToast("Config disimpan",true)
end

local function loadConfig()
    pcall(function()
        local str=readfile("VeronConfig.txt")
        for line in str:gmatch("[^\n]+") do
            local k,v=line:match("(.+)=(.+)")
            if k and v then
                if v=="true" then _G.VeronConfig[k]=true
                elseif v=="false" then _G.VeronConfig[k]=false
                else _G.VeronConfig[k]=v end
            end
        end
        showToast("Config di-load",true)
    end)
end

local cfgRow=Instance.new("Frame")
cfgRow.Size=UDim2.new(1,0,0,36) cfgRow.BackgroundTransparency=1 cfgRow.Parent=TabPages["Extra"]
local cfgLL=Instance.new("UIListLayout") cfgLL.FillDirection=Enum.FillDirection.Horizontal cfgLL.Padding=UDim.new(0,8) cfgLL.Parent=cfgRow
local SaveBtn=Instance.new("TextButton")
SaveBtn.Size=UDim2.new(0.5,-4,1,0) SaveBtn.BackgroundColor3=C.neonDim
SaveBtn.Text="💾 Save Config" SaveBtn.TextColor3=C.neonGlow
SaveBtn.TextSize=11 SaveBtn.Font=Enum.Font.GothamBold SaveBtn.BorderSizePixel=0 SaveBtn.Parent=cfgRow
local SBC2=Instance.new("UICorner") SBC2.CornerRadius=UDim.new(0,8) SBC2.Parent=SaveBtn
local LoadBtn=Instance.new("TextButton")
LoadBtn.Size=UDim2.new(0.5,-4,1,0) LoadBtn.BackgroundColor3=C.bg3
LoadBtn.Text="📂 Load Config" LoadBtn.TextColor3=C.neonGlow
LoadBtn.TextSize=11 LoadBtn.Font=Enum.Font.GothamBold LoadBtn.BorderSizePixel=0 LoadBtn.Parent=cfgRow
local LBC2=Instance.new("UICorner") LBC2.CornerRadius=UDim.new(0,8) LBC2.Parent=LoadBtn
SaveBtn.MouseButton1Click:Connect(saveConfig)
LoadBtn.MouseButton1Click:Connect(loadConfig)

-- ================================================
-- DISCORD WEBHOOK LOGGER
-- ================================================
createSection("Extra","DISCORD WEBHOOK")

local WEBHOOK_URL = "https://discord.com/api/webhooks/1548440747714289826/x1ukko9NJb9MJle61z51ive78eg5ZtsaYNjmdPJLWLFm4yU2wGxgcsnTxMfP5w3qMCMb"

-- Cari fungsi http yang tersedia di executor
local httpRequest = (syn and syn.request) or (http and http.request) or
                   (typeof(request)=="function" and request) or
                   (typeof(HttpRequest)=="function" and HttpRequest) or nil

local function sendWebhook(content)
    if not httpRequest then return end -- executor tidak support http
    pcall(function()
        local HttpService = game:GetService("HttpService")
        local gameName = "Unknown"
        pcall(function()
            gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        end)
        local body = HttpService:JSONEncode({
            username = "Veron Hub",
            embeds = {{
                title = "📡 Veron Hub Logger",
                color = 7077887,
                fields = {
                    {name="Player", value=LocalPlayer.Name.." ("..LocalPlayer.UserId..")", inline=true},
                    {name="Game",   value=gameName, inline=true},
                    {name="Server", value=game.JobId, inline=false},
                    {name="Log",    value=content,   inline=false},
                },
                footer = {text="Veron Hub v3.3"},
            }}
        })
        httpRequest({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"]="application/json"},
            Body = body,
        })
    end)
end

-- Auto send saat script dijalankan
task.spawn(function()
    task.wait(2) -- tunggu game fully loaded
    sendWebhook("🚀 Script dieksekusi")
end)

-- Toggle log chat ke webhook
createToggle("Extra","Log Chat → Webhook","Kirim chat ke Discord webhook",function(s) _G.WebhookChat=s end)
_G.WebhookChat=false

-- Intercept logChat yang sudah ada untuk juga kirim ke webhook
local origLogChat=logChat
logChat=function(player,msg)
    origLogChat(player,msg)
    if _G.WebhookChat then
        sendWebhook(player.Name..": "..msg)
    end
end

local testWH=Instance.new("TextButton")
testWH.Size=UDim2.new(1,0,0,28) testWH.BackgroundColor3=C.bg3
testWH.Text="📤 Test Webhook" testWH.TextColor3=C.neonGlow
testWH.TextSize=11 testWH.Font=Enum.Font.GothamBold testWH.BorderSizePixel=0
testWH.Parent=TabPages["Extra"]
local tWHC=Instance.new("UICorner") tWHC.CornerRadius=UDim.new(0,8) tWHC.Parent=testWH
testWH.MouseButton1Click:Connect(function()
    sendWebhook("✅ Test webhook dari Veron Hub v3.2 — server: "..game.JobId)
    showToast("Webhook terkirim",true)
end)

-- Combat test state for game-owned/admin systems.
_G.VeronCombatTest = combatTestEnabled

-- ================================================
print("✅ Veron Hub v3.3 | Made by Veron")
print("   RightCtrl = hide/show (bisa diubah di tab Extra)")
print("   v3.3: +KillAura +AutoParry +AimbotLock +Blink +TPCursor +SpeedSlider")
print("         +HealthESP +Crosshair +Radar +LoopTP +ChatSpam +ServerHop +Config +Webhook")
-- ================================================
