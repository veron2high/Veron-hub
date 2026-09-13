-- ================================================
-- VERON ADMIN+TROLL HUB v1.1 (REBUILD)
-- Key: VERON-ADMIN
-- Developer: veron2high
-- ================================================

local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local UIS           = game:GetService("UserInputService")
local TweenService  = game:GetService("TweenService")
local LP            = Players.LocalPlayer
local Character     = LP.Character or LP.CharacterAdded:Wait()
local Camera        = workspace.CurrentCamera
local VERON_KEY     = "VERON-ADMIN"

-- Parent
local GUI_PARENT
pcall(function()
    if typeof(gethui) == "function" then GUI_PARENT = gethui()
    else GUI_PARENT = game:GetService("CoreGui") end
end)
if not GUI_PARENT then GUI_PARENT = LP:WaitForChild("PlayerGui") end

-- Cleanup
for _, name in ipairs({"VATROLL_KEY","VATROLL_MAIN"}) do
    local old = GUI_PARENT:FindFirstChild(name)
    if old then old:Destroy() end
end

-- ================================================
-- COLORS
-- ================================================
local C = {
    bg       = Color3.fromRGB(8,  20, 10),
    bg2      = Color3.fromRGB(12, 35, 16),
    bg3      = Color3.fromRGB(18, 50, 22),
    neon     = Color3.fromRGB(34, 197, 94),
    neonDim  = Color3.fromRGB(21, 128, 61),
    neonGlow = Color3.fromRGB(134,239,172),
    text     = Color3.fromRGB(220,255,230),
    textDim  = Color3.fromRGB(80, 140, 90),
    white    = Color3.fromRGB(255,255,255),
    red      = Color3.fromRGB(248,113,113),
    green    = Color3.fromRGB(74, 222,128),
}

local function corner(inst, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = inst
end
local function stroke(inst, col, thick)
    local s = Instance.new("UIStroke")
    s.Color = col or C.neon
    s.Thickness = thick or 1.5
    s.Parent = inst
end

-- ================================================
-- KEY SYSTEM
-- ================================================
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "VATROLL_KEY"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.Parent = GUI_PARENT

local kFrame = Instance.new("Frame")
kFrame.Size = UDim2.new(0,340,0,240)
kFrame.Position = UDim2.new(0.5,-170,0.5,-120)
kFrame.BackgroundColor3 = C.bg
kFrame.BorderSizePixel = 0
kFrame.Parent = keyGui
corner(kFrame, 12) stroke(kFrame, C.neon)

local function kLabel(txt, y, size, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-20,0,30)
    l.Position = UDim2.new(0,10,0,y)
    l.BackgroundTransparency = 1
    l.Text = txt l.TextSize = size or 14
    l.Font = Enum.Font.GothamBold
    l.TextColor3 = color or C.neonGlow
    l.TextXAlignment = Enum.TextXAlignment.Center
    l.Parent = kFrame
    return l
end

kLabel("⚡ VERON ADMIN+TROLL HUB • KEY", 12, 15)

local kBox = Instance.new("TextBox")
kBox.Size = UDim2.new(1,-40,0,42)
kBox.Position = UDim2.new(0,20,0,55)
kBox.BackgroundColor3 = C.bg2
kBox.PlaceholderText = "Enter key..."
kBox.PlaceholderColor3 = C.textDim
kBox.Text = "" kBox.TextColor3 = C.white
kBox.TextSize = 14 kBox.Font = Enum.Font.Gotham
kBox.ClearTextOnFocus = false kBox.BorderSizePixel = 0
kBox.Parent = kFrame
corner(kBox) stroke(kBox, C.neon, 1)

local kBtn = Instance.new("TextButton")
kBtn.Size = UDim2.new(1,-40,0,42)
kBtn.Position = UDim2.new(0,20,0,108)
kBtn.BackgroundColor3 = C.neonDim
kBtn.Text = "VERIFY KEY" kBtn.TextColor3 = C.white
kBtn.TextSize = 14 kBtn.Font = Enum.Font.GothamBold
kBtn.BorderSizePixel = 0 kBtn.Parent = kFrame
corner(kBtn)

local kStatus = kLabel("Key required to continue", 158, 12, Color3.fromRGB(100,180,110))
kLabel("👑 Developer : veron2high", 192, 12)

local verified = false
local function checkKey()
    if kBox.Text == VERON_KEY then
        verified = true
        kStatus.Text = "✓ Key verified!"
        kStatus.TextColor3 = C.green
        kBtn.Text = "✔ VERIFIED"
        kBtn.BackgroundColor3 = C.neon
        task.wait(0.4)
        keyGui:Destroy()
    else
        kStatus.Text = "✕ Invalid key!"
        kStatus.TextColor3 = C.red
    end
end
kBtn.MouseButton1Click:Connect(checkKey)
kBox.FocusLost:Connect(function(enter) if enter then checkKey() end end)
repeat task.wait() until verified

-- ================================================
-- MAIN SCREENGUI
-- ================================================
local SG = Instance.new("ScreenGui")
SG.Name = "VATROLL_MAIN"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = GUI_PARENT

-- Open Button (shown when closed)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0,130,0,32)
OpenBtn.Position = UDim2.new(0,12,0,12)
OpenBtn.BackgroundColor3 = C.bg2
OpenBtn.Text = "⚡ ADMIN+TROLL"
OpenBtn.TextColor3 = C.neonGlow
OpenBtn.TextSize = 12 OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false OpenBtn.BorderSizePixel = 0
OpenBtn.Parent = SG
corner(OpenBtn) stroke(OpenBtn, C.neon, 1)

-- ================================================
-- MAIN FRAME
-- ================================================
local MF = Instance.new("Frame")
MF.Name = "MainFrame"
MF.Size = UDim2.new(0,500,0,560)
MF.Position = UDim2.new(0.5,-250,0.5,-280)
MF.BackgroundColor3 = C.bg
MF.BorderSizePixel = 0
MF.Active = true MF.Draggable = true
MF.Parent = SG
corner(MF, 14) stroke(MF, C.neon)

-- Title Bar
local TB = Instance.new("Frame")
TB.Size = UDim2.new(1,0,0,44)
TB.BackgroundColor3 = C.bg2
TB.BorderSizePixel = 0 TB.Parent = MF
corner(TB, 14)

local TL = Instance.new("TextLabel")
TL.Size = UDim2.new(1,-50,1,0)
TL.Position = UDim2.new(0,14,0,0)
TL.BackgroundTransparency = 1
TL.Text = "⚡  VERON ADMIN+TROLL HUB  |  v1.1"
TL.TextColor3 = C.neonGlow TL.TextSize = 13
TL.Font = Enum.Font.GothamBold
TL.TextXAlignment = Enum.TextXAlignment.Left
TL.Parent = TB

local XBtn = Instance.new("TextButton")
XBtn.Size = UDim2.new(0,28,0,28)
XBtn.Position = UDim2.new(1,-36,0.5,-14)
XBtn.BackgroundColor3 = Color3.fromRGB(80,20,20)
XBtn.Text = "✕" XBtn.TextColor3 = C.red
XBtn.TextSize = 13 XBtn.Font = Enum.Font.GothamBold
XBtn.BorderSizePixel = 0 XBtn.Parent = TB
corner(XBtn, 6)
XBtn.MouseButton1Click:Connect(function()
    MF.Visible = false OpenBtn.Visible = true
end)
OpenBtn.MouseButton1Click:Connect(function()
    MF.Visible = true OpenBtn.Visible = false
end)

-- ================================================
-- TAB BAR
-- ================================================
local TabNames = {"Players","Admin","Troll","Fake Admin"}
local TabBtns  = {}
local TabPages = {}

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1,-16,0,34)
TabBar.Position = UDim2.new(0,8,0,48)
TabBar.BackgroundColor3 = C.bg2
TabBar.BorderSizePixel = 0 TabBar.Parent = MF
corner(TabBar, 8)

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0,3)
tabLayout.Parent = TabBar
local tabPad = Instance.new("UIPadding")
tabPad.PaddingLeft = UDim.new(0,4)
tabPad.PaddingRight = UDim.new(0,4)
tabPad.PaddingTop = UDim.new(0,4)
tabPad.PaddingBottom = UDim.new(0,4)
tabPad.Parent = TabBar

for i, name in ipairs(TabNames) do
    -- Tab button
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25,-3,1,0)
    btn.BackgroundColor3 = C.bg3
    btn.Text = name
    btn.TextColor3 = C.textDim
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    corner(btn, 6)
    TabBtns[name] = btn

    -- Tab page — KEY FIX: use Frame not ScrollingFrame as outer, put ScrollingFrame inside
    local pageOuter = Instance.new("Frame")
    pageOuter.Name = "Page_"..name
    pageOuter.Size = UDim2.new(1,-16,1,-90)
    pageOuter.Position = UDim2.new(0,8,0,88)
    pageOuter.BackgroundTransparency = 1
    pageOuter.BorderSizePixel = 0
    pageOuter.ClipsDescendants = true
    pageOuter.Visible = (i == 1)
    pageOuter.Parent = MF

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1,0,1,0)
    scroll.Position = UDim2.new(0,0,0,0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = C.neon
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ClipsDescendants = true
    scroll.Parent = pageOuter

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    local pad = Instance.new("UIPadding")
    pad.PaddingTop    = UDim.new(0,6)
    pad.PaddingBottom = UDim.new(0,10)
    pad.PaddingLeft   = UDim.new(0,2)
    pad.PaddingRight  = UDim.new(0,2)
    pad.Parent = scroll

    TabPages[name] = scroll
end

local function switchTab(name)
    for n, _ in pairs(TabPages) do
        local outer = MF:FindFirstChild("Page_"..n)
        if outer then outer.Visible = (n == name) end
        local btn = TabBtns[n]
        btn.BackgroundColor3 = (n == name) and C.neonDim or C.bg3
        btn.TextColor3       = (n == name) and C.neonGlow or C.textDim
    end
end
for name, btn in pairs(TabBtns) do
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
end
switchTab("Players")

-- ================================================
-- TOAST
-- ================================================
local toastQueue = {}
local toastBusy  = false
local function showToast(msg, isOn)
    table.insert(toastQueue, {msg=msg, on=isOn})
    if toastBusy then return end
    toastBusy = true
    task.spawn(function()
        while #toastQueue > 0 do
            local d = table.remove(toastQueue, 1)
            local t = Instance.new("Frame")
            t.Size = UDim2.new(0,220,0,38)
            t.Position = UDim2.new(1,10,1,-48)
            t.BackgroundColor3 = C.bg2
            t.BorderSizePixel = 0
            t.Parent = SG
            corner(t, 10)
            stroke(t, d.on and C.neon or C.textDim, 1)
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0,7,0,7)
            dot.Position = UDim2.new(0,10,0.5,-3.5)
            dot.BackgroundColor3 = d.on and C.green or C.red
            dot.BorderSizePixel = 0 dot.Parent = t
            corner(dot, 10)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1,-26,1,0)
            lbl.Position = UDim2.new(0,24,0,0)
            lbl.BackgroundTransparency = 1
            lbl.Text = d.msg
            lbl.TextColor3 = d.on and C.neonGlow or C.textDim
            lbl.TextSize = 11 lbl.Font = Enum.Font.GothamBold
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = t
            TweenService:Create(t,TweenInfo.new(0.2),{Position=UDim2.new(1,-230,1,-48)}):Play()
            task.wait(2)
            local tw = TweenService:Create(t,TweenInfo.new(0.2),{Position=UDim2.new(1,10,1,-48)})
            tw:Play() tw.Completed:Wait() t:Destroy()
        end
        toastBusy = false
    end)
end

-- ================================================
-- HELPERS: makeSection / makeBtn / makeInputBtn
-- ================================================
local function makeSection(tab, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,0,18)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  ── "..text
    lbl.TextColor3 = C.neon lbl.TextSize = 10
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = TabPages[tab]
end

local function makeBtn(tab, label, sub, color, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,52)
    row.BackgroundColor3 = C.bg2
    row.BorderSizePixel = 0
    row.Parent = TabPages[tab]
    corner(row, 10) stroke(row, C.neonDim, 0.8)

    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(1,-90,0,20)
    nl.Position = UDim2.new(0,12,0,8)
    nl.BackgroundTransparency = 1
    nl.Text = label nl.TextColor3 = C.text
    nl.TextSize = 13 nl.Font = Enum.Font.GothamBold
    nl.TextXAlignment = Enum.TextXAlignment.Left nl.Parent = row

    if sub then
        local sl = Instance.new("TextLabel")
        sl.Size = UDim2.new(1,-90,0,14)
        sl.Position = UDim2.new(0,12,0,28)
        sl.BackgroundTransparency = 1
        sl.Text = sub sl.TextColor3 = C.textDim
        sl.TextSize = 11 sl.Font = Enum.Font.Gotham
        sl.TextXAlignment = Enum.TextXAlignment.Left sl.Parent = row
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,72,0,28)
    btn.Position = UDim2.new(1,-82,0.5,-14)
    btn.BackgroundColor3 = color or C.neonDim
    btn.Text = "RUN" btn.TextColor3 = C.white
    btn.TextSize = 12 btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0 btn.Parent = row
    corner(btn)
    btn.MouseButton1Click:Connect(cb)
    return row
end

local function makeInputBtn(tab, label, placeholder, btnText, btnColor, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,58)
    row.BackgroundColor3 = C.bg2
    row.BorderSizePixel = 0
    row.Parent = TabPages[tab]
    corner(row, 10) stroke(row, C.neonDim, 0.8)

    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(1,-12,0,18)
    nl.Position = UDim2.new(0,12,0,4)
    nl.BackgroundTransparency = 1
    nl.Text = label nl.TextColor3 = C.text
    nl.TextSize = 12 nl.Font = Enum.Font.GothamBold
    nl.TextXAlignment = Enum.TextXAlignment.Left nl.Parent = row

    local inp = Instance.new("TextBox")
    inp.Size = UDim2.new(0.58,-8,0,26)
    inp.Position = UDim2.new(0,8,0,28)
    inp.BackgroundColor3 = C.bg
    inp.Text = "" inp.PlaceholderText = placeholder
    inp.TextColor3 = C.text inp.PlaceholderColor3 = C.textDim
    inp.TextSize = 11 inp.Font = Enum.Font.Gotham
    inp.BorderSizePixel = 0 inp.ClearTextOnFocus = false
    inp.Parent = row
    corner(inp, 6)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.42,-8,0,26)
    btn.Position = UDim2.new(0.58,4,0,28)
    btn.BackgroundColor3 = btnColor or C.neonDim
    btn.Text = btnText or "RUN"
    btn.TextColor3 = C.white btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold btn.BorderSizePixel = 0
    btn.Parent = row
    corner(btn, 6)
    btn.MouseButton1Click:Connect(function() cb(inp.Text) end)
    return row, inp
end

-- ================================================
-- SELECTED TARGET
-- ================================================
local selectedTarget = nil

local targetLabel = Instance.new("TextLabel")
targetLabel.Size = UDim2.new(1,0,0,26)
targetLabel.BackgroundColor3 = C.bg3
targetLabel.Text = "🎯 Target: Belum dipilih"
targetLabel.TextColor3 = C.neonGlow
targetLabel.TextSize = 11 targetLabel.Font = Enum.Font.GothamBold
targetLabel.BorderSizePixel = 0
corner(targetLabel, 8)
targetLabel.Parent = TabPages["Players"]

-- ================================================
-- TAB: PLAYERS
-- ================================================
makeSection("Players","PLAYER LIST — Klik untuk pilih target")

local plFrame = Instance.new("Frame")
plFrame.Size = UDim2.new(1,0,0,0)
plFrame.AutomaticSize = Enum.AutomaticSize.Y
plFrame.BackgroundColor3 = C.bg2
plFrame.BorderSizePixel = 0
plFrame.Parent = TabPages["Players"]
corner(plFrame, 10)
local plLayout2 = Instance.new("UIListLayout")
plLayout2.Padding = UDim.new(0,3) plLayout2.Parent = plFrame
local plPad = Instance.new("UIPadding")
plPad.PaddingTop = UDim.new(0,6) plPad.PaddingBottom = UDim.new(0,6)
plPad.PaddingLeft = UDim.new(0,6) plPad.PaddingRight = UDim.new(0,6)
plPad.Parent = plFrame

local playerRows = {}
local function refreshPlayerList()
    for _, r in pairs(playerRows) do r:Destroy() end
    playerRows = {}
    for _, p in ipairs(Players:GetPlayers()) do
        local row = Instance.new("TextButton")
        row.Size = UDim2.new(1,0,0,34)
        row.BackgroundColor3 = p == LP and C.bg3 or C.bg
        row.BorderSizePixel = 0 row.Text = "" row.Parent = plFrame
        corner(row, 8)
        stroke(row, p == LP and C.neon or C.neonDim, 0.5)

        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0,7,0,7)
        dot.Position = UDim2.new(0,10,0.5,-3.5)
        dot.BackgroundColor3 = p == LP and C.green or C.neon
        dot.BorderSizePixel = 0 dot.Parent = row
        corner(dot, 10)

        local nl = Instance.new("TextLabel")
        nl.Size = UDim2.new(0.7,0,1,0)
        nl.Position = UDim2.new(0,22,0,0)
        nl.BackgroundTransparency = 1
        nl.Text = (p == LP and "[You] " or "") .. p.Name
        nl.TextColor3 = p == LP and C.green or C.text
        nl.TextSize = 12 nl.Font = Enum.Font.GothamBold
        nl.TextXAlignment = Enum.TextXAlignment.Left nl.Parent = row

        local selLbl = Instance.new("TextLabel")
        selLbl.Size = UDim2.new(0.3,0,1,0)
        selLbl.Position = UDim2.new(0.7,0,0,0)
        selLbl.BackgroundTransparency = 1
        selLbl.Text = selectedTarget == p and "✔ SELECTED" or ""
        selLbl.TextColor3 = C.neonGlow selLbl.TextSize = 10
        selLbl.Font = Enum.Font.GothamBold
        selLbl.TextXAlignment = Enum.TextXAlignment.Right selLbl.Parent = row

        if p ~= LP then
            row.MouseButton1Click:Connect(function()
                selectedTarget = p
                targetLabel.Text = "🎯 Target: "..p.Name
                showToast("Target: "..p.Name, true)
                refreshPlayerList()
            end)
        end
        table.insert(playerRows, row)
    end
end
refreshPlayerList()

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1,0,0,28)
refreshBtn.BackgroundColor3 = C.bg3
refreshBtn.Text = "🔄 Refresh List"
refreshBtn.TextColor3 = C.neonGlow refreshBtn.TextSize = 11
refreshBtn.Font = Enum.Font.GothamBold refreshBtn.BorderSizePixel = 0
refreshBtn.Parent = TabPages["Players"]
corner(refreshBtn, 8)
refreshBtn.MouseButton1Click:Connect(refreshPlayerList)
Players.PlayerAdded:Connect(function() task.wait(0.3) refreshPlayerList() end)
Players.PlayerRemoving:Connect(function() task.wait(0.1) refreshPlayerList() end)

-- ================================================
-- TAB: ADMIN
-- ================================================
makeSection("Admin","TARGET ACTIONS")

makeBtn("Admin","Kick Player","Keluarkan target dari server",Color3.fromRGB(153,27,27),function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    pcall(function() game:GetService("TeleportService"):Teleport(0,t) end)
    showToast("Kick: "..t.Name, true)
end)

local frozenPlayers = {}
makeBtn("Admin","Freeze / Unfreeze","Bekukan target di tempat",C.neonDim,function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    local char = t.Character if not char then return end
    if frozenPlayers[t] then
        frozenPlayers[t]:Disconnect() frozenPlayers[t] = nil
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 hum.JumpPower = 50 end
        showToast("Unfreeze: "..t.Name, false)
    else
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 0 hum.JumpPower = 0 end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local frozenCF = hrp and hrp.CFrame
        frozenPlayers[t] = RunService.Heartbeat:Connect(function()
            if hrp and hrp.Parent and frozenCF then hrp.CFrame = frozenCF end
        end)
        showToast("Freeze: "..t.Name, true)
    end
end)

makeBtn("Admin","Bring Player","Tarik target ke posisi kamu",C.neonDim,function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    local myR = Character and Character:FindFirstChild("HumanoidRootPart")
    local tR = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if myR and tR then tR.CFrame = myR.CFrame + Vector3.new(2,0,0) showToast("Bring: "..t.Name,true) end
end)

makeBtn("Admin","TP to Player","Teleport kamu ke target",C.neonDim,function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    local myR = Character and Character:FindFirstChild("HumanoidRootPart")
    local tR = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if myR and tR then myR.CFrame = tR.CFrame + Vector3.new(0,3,0) showToast("TP to: "..t.Name,true) end
end)

makeBtn("Admin","God Mode (Local)","Set HP target ke max (lokal)",C.neonDim,function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    local hum = t.Character and t.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = hum.MaxHealth showToast("God: "..t.Name,true) end
end)

makeSection("Admin","SERVER ACTIONS")

makeBtn("Admin","Spectate Player","Ikuti kamera ke target",C.neonDim,function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    local hum = t.Character and t.Character:FindFirstChildOfClass("Humanoid")
    if hum then Camera.CameraSubject = hum showToast("Spectate: "..t.Name,true) end
end)

makeBtn("Admin","Stop Spectate","Kembali ke kamera normal",Color3.fromRGB(120,60,20),function()
    local myHum = Character and Character:FindFirstChildOfClass("Humanoid")
    Camera.CameraSubject = myHum showToast("Spectate OFF",false)
end)

makeInputBtn("Admin","📢 Announce (Local)","Tulis pesan...","SEND",C.neonDim,function(msg)
    if msg == "" then return end
    local ann = Instance.new("Frame")
    ann.Size = UDim2.new(0.7,0,0,50) ann.Position = UDim2.new(0.15,0,0,80)
    ann.BackgroundColor3 = C.bg2 ann.BorderSizePixel = 0 ann.Parent = SG
    corner(ann, 12) stroke(ann, C.neon, 2)
    local al = Instance.new("TextLabel")
    al.Size = UDim2.new(1,-20,1,0) al.Position = UDim2.new(0,10,0,0)
    al.BackgroundTransparency = 1 al.Text = "📢 [ADMIN]: "..msg
    al.TextColor3 = C.neonGlow al.TextSize = 14 al.Font = Enum.Font.GothamBold
    al.TextXAlignment = Enum.TextXAlignment.Center al.TextWrapped = true al.Parent = ann
    task.delay(4, function() ann:Destroy() end)
    showToast("Announce terkirim",true)
end)

-- ================================================
-- TAB: TROLL
-- ================================================
makeSection("Troll","TROLL ACTIONS — Pilih target dulu")

makeBtn("Troll","Fling Player","Lempar target jauh",Color3.fromRGB(153,27,27),function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    local hrp = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        pcall(function()
            hrp.AssemblyLinearVelocity = Vector3.new(
                math.random(-300,300), math.random(200,500), math.random(-300,300))
        end)
        showToast("Fling: "..t.Name,true)
    end
end)

local spinConns = {}
makeBtn("Troll","Spin Player","Putar target terus (klik lagi untuk stop)",C.neonDim,function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    if spinConns[t] then
        spinConns[t]:Disconnect() spinConns[t] = nil
        showToast("Stop Spin: "..t.Name,false) return
    end
    local angle = 0
    spinConns[t] = RunService.Heartbeat:Connect(function()
        local root = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
        if root then
            angle = angle + 15
            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0,math.rad(angle),0)
        end
    end)
    showToast("Spin: "..t.Name,true)
end)

local jailParts = {}
makeBtn("Troll","Jail Player","Kurung target (klik lagi untuk bebas)",Color3.fromRGB(120,60,20),function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!",false) return end
    if jailParts[t] then
        for _, p in pairs(jailParts[t]) do p:Destroy() end
        jailParts[t] = nil showToast("Unjail: "..t.Name,false) return
    end
    local hrp = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local pos = hrp.Position
    local walls = {
        {Vector3.new(pos.X,pos.Y,pos.Z+4),   Vector3.new(6,10,0.5)},
        {Vector3.new(pos.X,pos.Y,pos.Z-4),   Vector3.new(6,10,0.5)},
        {Vector3.new(pos.X+3,pos.Y,pos.Z),   Vector3.new(0.5,10,8)},
        {Vector3.new(pos.X-3,pos.Y,pos.Z),   Vector3.new(0.5,10,8)},
        {Vector3.new(pos.X,pos.Y+5,pos.Z),   Vector3.new(6,0.5,8)},
    }
    jailParts[t] = {}
    for _, w in ipairs(walls) do
        local p = Instance.new("Part")
        p.Size = w[2] p.Position = w[1]
        p.Anchored = true p.CanCollide = true
        p.Transparency = 0.7 p.BrickColor = BrickColor.new("Bright green")
        p.Material = Enum.Material.Neon p.Parent = workspace
        table.insert(jailParts[t], p)
    end
    showToast("Jail: "..t.Name,true)
end)

makeBtn("Troll","Lag Spike (Local)","Bikin client lag sebentar",Color3.fromRGB(90,20,90),function()
    showToast("Lag spike dimulai...",true)
    task.spawn(function()
        local s = tick()
        while tick()-s < 2 do for i=1,5000 do local _=math.sqrt(i) end end
        showToast("Lag spike selesai",false)
    end)
end)

makeSection("Troll","CHAT TROLL")

makeInputBtn("Troll","💬 Chat Spam","Pesan spam...","SPAM",Color3.fromRGB(90,20,90),function(msg)
    if msg == "" then return end
    task.spawn(function()
        for i=1,10 do
            pcall(function()
                game:GetService("ReplicatedStorage")
                    :FindFirstChild("DefaultChatSystemChatEvents")
                    :FindFirstChild("SayMessageRequest")
                    :FireServer(msg,"All")
            end)
            task.wait(0.5)
        end
    end)
    showToast("Chat spam dikirim",true)
end)

makeSection("Troll","QUICK CHAT TROLL")

local trollMessages = {
    "🔴 [SYSTEM]: Server akan direstart dalam 30 detik!",
    "⚠️ [ADMIN]: Semua player akan dikick dalam 10 detik!",
    "🎉 Player "..LP.Name.." mendapat hadiah Robux gratis!",
    "💀 HACKED BY VERON",
    "🚨 EMERGENCY: Server ini tidak aman!",
}
for _, tmsg in ipairs(trollMessages) do
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundColor3 = C.bg2 row.BorderSizePixel = 0
    row.Parent = TabPages["Troll"]
    corner(row, 8) stroke(row, C.neonDim, 0.5)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-80,1,0) lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = tmsg:sub(1,48)..(#tmsg>48 and "..." or "")
    lbl.TextColor3 = C.text lbl.TextSize = 10 lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left lbl.Parent = row

    local sBtn = Instance.new("TextButton")
    sBtn.Size = UDim2.new(0,60,0,24) sBtn.Position = UDim2.new(1,-68,0.5,-12)
    sBtn.BackgroundColor3 = C.neonDim sBtn.Text = "Send"
    sBtn.TextColor3 = C.white sBtn.TextSize = 11
    sBtn.Font = Enum.Font.GothamBold sBtn.BorderSizePixel = 0
    sBtn.Parent = row corner(sBtn, 6)
    sBtn.MouseButton1Click:Connect(function()
        pcall(function()
            game:GetService("ReplicatedStorage")
                :FindFirstChild("DefaultChatSystemChatEvents")
                :FindFirstChild("SayMessageRequest"):FireServer(tmsg,"All")
        end)
        showToast("Chat terkirim!",true)
    end)
end

-- ================================================
-- TAB: FAKE ADMIN
-- ================================================
makeSection("Fake Admin","FAKE ADMIN PANEL")

local fakeAdminGui = nil
makeBtn("Fake Admin","Show Fake Admin Panel","Tampilkan UI palsu seperti admin",C.neonDim,function()
    if fakeAdminGui then fakeAdminGui:Destroy() fakeAdminGui = nil end

    fakeAdminGui = Instance.new("ScreenGui")
    fakeAdminGui.Name = "FakeAdminGui"
    fakeAdminGui.ResetOnSpawn = false
    fakeAdminGui.IgnoreGuiInset = true
    fakeAdminGui.Parent = GUI_PARENT

    local faBg = Instance.new("Frame")
    faBg.Size = UDim2.new(0,360,0,420)
    faBg.Position = UDim2.new(0.5,-180,0.5,-210)
    faBg.BackgroundColor3 = Color3.fromRGB(10,15,30)
    faBg.BorderSizePixel = 0 faBg.Active = true faBg.Draggable = true
    faBg.Parent = fakeAdminGui
    corner(faBg, 14) stroke(faBg, Color3.fromRGB(59,130,246), 2)

    local faTB = Instance.new("Frame")
    faTB.Size = UDim2.new(1,0,0,44)
    faTB.BackgroundColor3 = Color3.fromRGB(20,30,60)
    faTB.BorderSizePixel = 0 faTB.Parent = faBg
    corner(faTB, 14)

    local faTL = Instance.new("TextLabel")
    faTL.Size = UDim2.new(1,-50,1,0) faTL.Position = UDim2.new(0,14,0,0)
    faTL.BackgroundTransparency = 1
    faTL.Text = "🛡️  ADMIN PANEL  |  "..LP.Name
    faTL.TextColor3 = Color3.fromRGB(147,197,253) faTL.TextSize = 13
    faTL.Font = Enum.Font.GothamBold
    faTL.TextXAlignment = Enum.TextXAlignment.Left faTL.Parent = faTB

    local faX = Instance.new("TextButton")
    faX.Size = UDim2.new(0,28,0,28) faX.Position = UDim2.new(1,-36,0.5,-14)
    faX.BackgroundColor3 = Color3.fromRGB(80,20,20)
    faX.Text = "✕" faX.TextColor3 = C.red faX.TextSize = 13
    faX.Font = Enum.Font.GothamBold faX.BorderSizePixel = 0 faX.Parent = faTB
    corner(faX, 6)
    faX.MouseButton1Click:Connect(function() fakeAdminGui:Destroy() fakeAdminGui = nil end)

    local faScroll = Instance.new("ScrollingFrame")
    faScroll.Size = UDim2.new(1,-16,1,-54) faScroll.Position = UDim2.new(0,8,0,50)
    faScroll.BackgroundTransparency = 1 faScroll.BorderSizePixel = 0
    faScroll.ScrollBarThickness = 3
    faScroll.ScrollBarImageColor3 = Color3.fromRGB(59,130,246)
    faScroll.CanvasSize = UDim2.new(0,0,0,0)
    faScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    faScroll.ClipsDescendants = true faScroll.Parent = faBg
    local faL = Instance.new("UIListLayout") faL.Padding = UDim.new(0,6) faL.Parent = faScroll
    local faPad = Instance.new("UIPadding") faPad.PaddingTop = UDim.new(0,4) faPad.Parent = faScroll

    local fakeCommands = {
        {"🚫 Kick All","Keluarkan semua player"},
        {"🔇 Mute All","Bisukan semua chat"},
        {"⚡ Speed All","Speed 100 semua player"},
        {"🌙 Night Mode","Ubah waktu jadi malam"},
        {"🔒 Lock Server","Kunci server dari player baru"},
        {"💣 Explode All","Ledakkan semua player"},
        {"🎭 Shutdown","Matikan server"},
        {"👁️ Spy Mode","Pantau semua player"},
    }
    for _, cmd in ipairs(fakeCommands) do
        local cmdRow = Instance.new("Frame")
        cmdRow.Size = UDim2.new(1,0,0,44)
        cmdRow.BackgroundColor3 = Color3.fromRGB(15,25,50)
        cmdRow.BorderSizePixel = 0 cmdRow.Parent = faScroll
        corner(cmdRow, 8)
        stroke(cmdRow, Color3.fromRGB(59,130,246), 0.5)

        local cmdLbl = Instance.new("TextLabel")
        cmdLbl.Size = UDim2.new(1,-80,0,20) cmdLbl.Position = UDim2.new(0,12,0,6)
        cmdLbl.BackgroundTransparency = 1 cmdLbl.Text = cmd[1]
        cmdLbl.TextColor3 = Color3.fromRGB(200,220,255) cmdLbl.TextSize = 12
        cmdLbl.Font = Enum.Font.GothamBold
        cmdLbl.TextXAlignment = Enum.TextXAlignment.Left cmdLbl.Parent = cmdRow

        local cmdSub = Instance.new("TextLabel")
        cmdSub.Size = UDim2.new(1,-80,0,14) cmdSub.Position = UDim2.new(0,12,0,26)
        cmdSub.BackgroundTransparency = 1 cmdSub.Text = cmd[2]
        cmdSub.TextColor3 = Color3.fromRGB(80,120,180) cmdSub.TextSize = 10
        cmdSub.Font = Enum.Font.Gotham
        cmdSub.TextXAlignment = Enum.TextXAlignment.Left cmdSub.Parent = cmdRow

        local cmdBtn = Instance.new("TextButton")
        cmdBtn.Size = UDim2.new(0,64,0,26) cmdBtn.Position = UDim2.new(1,-72,0.5,-13)
        cmdBtn.BackgroundColor3 = Color3.fromRGB(29,78,216)
        cmdBtn.Text = "EXECUTE" cmdBtn.TextColor3 = C.white
        cmdBtn.TextSize = 10 cmdBtn.Font = Enum.Font.GothamBold
        cmdBtn.BorderSizePixel = 0 cmdBtn.Parent = cmdRow
        corner(cmdBtn, 6)
        cmdBtn.MouseButton1Click:Connect(function()
            cmdBtn.Text = "..."
            cmdBtn.BackgroundColor3 = Color3.fromRGB(21,128,61)
            task.delay(1.5,function()
                cmdBtn.Text = "✔ DONE"
                task.delay(2,function()
                    cmdBtn.Text = "EXECUTE"
                    cmdBtn.BackgroundColor3 = Color3.fromRGB(29,78,216)
                end)
            end)
        end)
    end
    showToast("Fake Admin Panel dibuka",true)
end)

makeSection("Fake Admin","FAKE NOTIFICATION")

makeInputBtn("Fake Admin","📨 Fake System Notif","Tulis pesan sistem palsu...","SEND",C.neonDim,function(msg)
    if msg == "" then return end
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0,320,0,60)
    notif.Position = UDim2.new(0.5,-160,0,-70)
    notif.BackgroundColor3 = Color3.fromRGB(15,25,50)
    notif.BorderSizePixel = 0 notif.Parent = SG
    corner(notif, 12) stroke(notif, Color3.fromRGB(59,130,246), 2)

    local nl2 = Instance.new("TextLabel")
    nl2.Size = UDim2.new(1,-20,0.5,0) nl2.Position = UDim2.new(0,10,0,2)
    nl2.BackgroundTransparency = 1 nl2.Text = "🛡️ ROBLOX SYSTEM"
    nl2.TextColor3 = Color3.fromRGB(59,130,246) nl2.TextSize = 11
    nl2.Font = Enum.Font.GothamBold
    nl2.TextXAlignment = Enum.TextXAlignment.Left nl2.Parent = notif

    local nl3 = Instance.new("TextLabel")
    nl3.Size = UDim2.new(1,-20,0.5,0) nl3.Position = UDim2.new(0,10,0.5,0)
    nl3.BackgroundTransparency = 1 nl3.Text = msg
    nl3.TextColor3 = Color3.fromRGB(200,220,255) nl3.TextSize = 12
    nl3.Font = Enum.Font.Gotham
    nl3.TextXAlignment = Enum.TextXAlignment.Left nl3.TextWrapped = true nl3.Parent = notif

    TweenService:Create(notif,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Position=UDim2.new(0.5,-160,0,12)}):Play()
    task.delay(4,function()
        TweenService:Create(notif,TweenInfo.new(0.3),{Position=UDim2.new(0.5,-160,0,-70)}):Play()
        task.wait(0.35) notif:Destroy()
    end)
    showToast("Notif terkirim",true)
end)

makeSection("Fake Admin","FAKE RANK BADGE")

makeBtn("Fake Admin","Show Fake Admin Badge","Pasang badge Admin di atas kepala",C.neonDim,function()
    local myChar = LP.Character
    if not myChar then return end
    local hrp = myChar:FindFirstChild("HumanoidRootPart") if not hrp then return end
    if hrp:FindFirstChild("FakeAdminBadge") then
        hrp:FindFirstChild("FakeAdminBadge"):Destroy()
        showToast("Badge dicopot",false) return
    end
    local bb = Instance.new("BillboardGui")
    bb.Name = "FakeAdminBadge" bb.Size = UDim2.new(0,120,0,28)
    bb.StudsOffset = Vector3.new(0,3.5,0) bb.AlwaysOnTop = true
    bb.Adornee = hrp bb.Parent = hrp

    local bg2 = Instance.new("Frame")
    bg2.Size = UDim2.new(1,0,1,0)
    bg2.BackgroundColor3 = Color3.fromRGB(10,15,30)
    bg2.BorderSizePixel = 0 bg2.Parent = bb
    corner(bg2, 6) stroke(bg2, Color3.fromRGB(59,130,246), 1.5)

    local bl = Instance.new("TextLabel")
    bl.Size = UDim2.new(1,0,1,0) bl.BackgroundTransparency = 1
    bl.Text = "🛡️ SERVER ADMIN"
    bl.TextColor3 = Color3.fromRGB(147,197,253) bl.TextSize = 11
    bl.Font = Enum.Font.GothamBold
    bl.TextXAlignment = Enum.TextXAlignment.Center bl.Parent = bg2

    showToast("Badge Admin dipasang",true)
end)

-- ================================================
-- KEYBIND
-- ================================================
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        MF.Visible = not MF.Visible
        OpenBtn.Visible = not MF.Visible
    end
end)

-- ================================================
-- RESPAWN
-- ================================================
LP.CharacterAdded:Connect(function(newChar) Character = newChar end)

print("✅ VERON ADMIN+TROLL HUB v1.1 REBUILD | Dev: veron2high")
print("   RightCtrl = hide/show | Key: VERON-ADMIN")
