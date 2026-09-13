-- ================================================
-- VERON ADMIN+TROLL HUB v1.0
-- Key: VERON-ADMIN
-- Developer: veron2high
-- ================================================

local VERON_KEY = "VERON-ADMIN"
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Camera = workspace.CurrentCamera

-- ================================================
-- PARENT SETUP
-- ================================================
local CoreGui = game:GetService("CoreGui")
local VERON_PARENT
pcall(function()
    if typeof(gethui) == "function" then
        VERON_PARENT = gethui()
    end
end)
if not VERON_PARENT then
    pcall(function() VERON_PARENT = CoreGui end)
end
if not VERON_PARENT then
    VERON_PARENT = LocalPlayer:WaitForChild("PlayerGui")
end

-- ================================================
-- KEY SYSTEM UI
-- ================================================
local oldKeyGui = VERON_PARENT:FindFirstChild("VATROLL_KEY")
if oldKeyGui then oldKeyGui:Destroy() end

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "VATROLL_KEY"
keyGui.ResetOnSpawn = false
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
keyGui.Parent = VERON_PARENT

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 240)
frame.Position = UDim2.new(0.5, -170, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(8, 20, 10)
frame.BorderSizePixel = 0
frame.Parent = keyGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(34, 197, 94)
stroke.Thickness = 1.5

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 12)
title.BackgroundTransparency = 1
title.Text = "⚡ VERON ADMIN+TROLL HUB • KEY"
title.TextColor3 = Color3.fromRGB(74, 222, 128)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -40, 0, 42)
box.Position = UDim2.new(0, 20, 0, 62)
box.BackgroundColor3 = Color3.fromRGB(12, 35, 16)
box.PlaceholderText = "Enter key..."
box.PlaceholderColor3 = Color3.fromRGB(60, 120, 70)
box.Text = ""
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.TextSize = 14
box.Font = Enum.Font.Gotham
box.ClearTextOnFocus = false
box.Parent = frame
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
local boxStroke = Instance.new("UIStroke", box)
boxStroke.Color = Color3.fromRGB(34, 197, 94)
boxStroke.Thickness = 1

local verify = Instance.new("TextButton")
verify.Size = UDim2.new(1, -40, 0, 42)
verify.Position = UDim2.new(0, 20, 0, 115)
verify.BackgroundColor3 = Color3.fromRGB(21, 128, 61)
verify.Text = "VERIFY KEY"
verify.TextColor3 = Color3.fromRGB(255, 255, 255)
verify.TextSize = 14
verify.Font = Enum.Font.GothamBold
verify.Parent = frame
Instance.new("UICorner", verify).CornerRadius = UDim.new(0, 8)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 25)
status.Position = UDim2.new(0, 20, 0, 164)
status.BackgroundTransparency = 1
status.Text = "Key required to continue"
status.TextColor3 = Color3.fromRGB(100, 180, 110)
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Center
status.Parent = frame

local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, -20, 0, 20)
credit.Position = UDim2.new(0, 10, 0, 196)
credit.BackgroundTransparency = 1
credit.Text = "👑 Developer : veron2high"
credit.TextColor3 = Color3.fromRGB(74, 222, 128)
credit.TextSize = 12
credit.Font = Enum.Font.GothamBold
credit.TextXAlignment = Enum.TextXAlignment.Center
credit.Parent = frame

local verified = false
local function checkKey()
    if box.Text == VERON_KEY then
        verified = true
        status.Text = "✓ Key verified!"
        status.TextColor3 = Color3.fromRGB(74, 222, 128)
        verify.Text = "✔ VERIFIED"
        verify.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        task.wait(0.4)
        keyGui:Destroy()
        return true
    end
    status.Text = "✕ Invalid key!"
    status.TextColor3 = Color3.fromRGB(255, 85, 85)
    return false
end

verify.MouseButton1Click:Connect(checkKey)
box.FocusLost:Connect(function(enter) if enter then checkKey() end end)

repeat task.wait() until verified

-- ================================================
-- MAIN HUB
-- ================================================

local C = {
    bg   = Color3.fromRGB(8, 20, 10),
    bg2  = Color3.fromRGB(12, 35, 16),
    bg3  = Color3.fromRGB(18, 50, 22),
    neon = Color3.fromRGB(34, 197, 94),
    neonDim = Color3.fromRGB(21, 128, 61),
    neonGlow = Color3.fromRGB(134, 239, 172),
    text = Color3.fromRGB(220, 255, 230),
    textDim = Color3.fromRGB(80, 140, 90),
    white = Color3.fromRGB(255, 255, 255),
    red = Color3.fromRGB(248, 113, 113),
    green = Color3.fromRGB(74, 222, 128),
}

-- Cleanup old
if VERON_PARENT:FindFirstChild("VATROLL_MAIN") then
    VERON_PARENT:FindFirstChild("VATROLL_MAIN"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VATROLL_MAIN"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = VERON_PARENT

-- Open Button
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 130, 0, 32)
OpenBtn.Position = UDim2.new(0, 12, 0, 12)
OpenBtn.BackgroundColor3 = C.bg2
OpenBtn.Text = "⚡ ADMIN+TROLL"
OpenBtn.TextColor3 = C.neonGlow
OpenBtn.TextSize = 12
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false
OpenBtn.BorderSizePixel = 0
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)
local OS2 = Instance.new("UIStroke", OpenBtn)
OS2.Color = C.neon
OS2.Thickness = 1

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 560)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -280)
MainFrame.BackgroundColor3 = C.bg
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
local MFS2 = Instance.new("UIStroke", MainFrame)
MFS2.Color = C.neon
MFS2.Thickness = 1.5

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = C.bg2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 14)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡  VERON ADMIN+TROLL HUB  |  v1.0"
TitleLabel.TextColor3 = C.neonGlow
TitleLabel.TextSize = 13
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
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

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
TabBar.Size = UDim2.new(1, -16, 0, 30)
TabBar.Position = UDim2.new(0, 8, 0, 48)
TabBar.BackgroundColor3 = C.bg2
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 8)

local TabNames = {"Players", "Admin", "Troll", "Fake Admin"}
local TabBtns = {}
local TabPages = {}

for i, name in ipairs(TabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, -2, 1, -6)
    btn.Position = UDim2.new((i-1)*0.25, 1, 0, 3)
    btn.BackgroundColor3 = C.bg3
    btn.Text = name
    btn.TextColor3 = C.textDim
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    TabBtns[name] = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -16, 0, 400)
    page.Position = UDim2.new(0, 8, 0, 86)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = C.neon
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = i == 1
    page.ClipsDescendants = false
    page.Parent = MainFrame
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 6)
    pad.PaddingBottom = UDim.new(0, 6)
    pad.PaddingLeft = UDim.new(0, 2)
    pad.PaddingRight = UDim.new(0, 2)
    pad.Parent = page
    TabPages[name] = page
end

local function switchTab(name)
    for n, page in pairs(TabPages) do
        page.Visible = n == name
        local btn = TabBtns[n]
        btn.BackgroundColor3 = n == name and C.neonDim or C.bg3
        btn.TextColor3 = n == name and C.neonGlow or C.textDim
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
local toastBusy = false

local function showToast(msg, isOn)
    table.insert(toastQueue, {msg = msg, on = isOn})
    if toastBusy then return end
    toastBusy = true
    task.spawn(function()
        while #toastQueue > 0 do
            local d = table.remove(toastQueue, 1)
            local toast = Instance.new("Frame")
            toast.Size = UDim2.new(0, 220, 0, 38)
            toast.Position = UDim2.new(1, 10, 1, -48)
            toast.BackgroundColor3 = C.bg2
            toast.BorderSizePixel = 0
            toast.Parent = ScreenGui
            Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
            local ts = Instance.new("UIStroke", toast)
            ts.Color = d.on and C.neon or C.textDim
            ts.Thickness = 1
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 7, 0, 7)
            dot.Position = UDim2.new(0, 10, 0.5, -3.5)
            dot.BackgroundColor3 = d.on and C.green or C.red
            dot.BorderSizePixel = 0
            dot.Parent = toast
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -26, 1, 0)
            lbl.Position = UDim2.new(0, 24, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = d.msg
            lbl.TextColor3 = d.on and C.neonGlow or C.textDim
            lbl.TextSize = 11
            lbl.Font = Enum.Font.GothamBold
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = toast
            TweenService:Create(toast, TweenInfo.new(0.2), {Position = UDim2.new(1, -230, 1, -48)}):Play()
            task.wait(2)
            local tw = TweenService:Create(toast, TweenInfo.new(0.2), {Position = UDim2.new(1, 10, 1, -48)})
            tw:Play()
            tw.Completed:Wait()
            toast:Destroy()
        end
        toastBusy = false
    end)
end

-- ================================================
-- HELPERS
-- ================================================
local function makeSection(tab, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  ── " .. text
    lbl.TextColor3 = C.neon
    lbl.TextSize = 10
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = TabPages[tab]
end

local function makeBtn(tab, label, sub, color, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 48)
    row.BackgroundColor3 = C.bg2
    row.BorderSizePixel = 0
    row.Parent = TabPages[tab]
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
    local rs = Instance.new("UIStroke", row)
    rs.Color = C.neonDim
    rs.Thickness = 0.8

    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(1, -90, 0, 20)
    nl.Position = UDim2.new(0, 12, 0, 6)
    nl.BackgroundTransparency = 1
    nl.Text = label
    nl.TextColor3 = C.text
    nl.TextSize = 13
    nl.Font = Enum.Font.GothamBold
    nl.TextXAlignment = Enum.TextXAlignment.Left
    nl.Parent = row

    if sub then
        local sl = Instance.new("TextLabel")
        sl.Size = UDim2.new(1, -90, 0, 14)
        sl.Position = UDim2.new(0, 12, 0, 28)
        sl.BackgroundTransparency = 1
        sl.Text = sub
        sl.TextColor3 = C.textDim
        sl.TextSize = 11
        sl.Font = Enum.Font.Gotham
        sl.TextXAlignment = Enum.TextXAlignment.Left
        sl.Parent = row
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 72, 0, 28)
    btn.Position = UDim2.new(1, -82, 0.5, -14)
    btn.BackgroundColor3 = color or C.neonDim
    btn.Text = "RUN"
    btn.TextColor3 = C.white
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(cb)
    return row
end

local function makeInputBtn(tab, label, placeholder, btnText, btnColor, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 54)
    row.BackgroundColor3 = C.bg2
    row.BorderSizePixel = 0
    row.Parent = TabPages[tab]
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
    local rs = Instance.new("UIStroke", row)
    rs.Color = C.neonDim
    rs.Thickness = 0.8

    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(1, -12, 0, 18)
    nl.Position = UDim2.new(0, 12, 0, 4)
    nl.BackgroundTransparency = 1
    nl.Text = label
    nl.TextColor3 = C.text
    nl.TextSize = 12
    nl.Font = Enum.Font.GothamBold
    nl.TextXAlignment = Enum.TextXAlignment.Left
    nl.Parent = row

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.58, -8, 0, 26)
    input.Position = UDim2.new(0, 8, 0, 24)
    input.BackgroundColor3 = C.bg
    input.Text = ""
    input.PlaceholderText = placeholder
    input.TextColor3 = C.text
    input.PlaceholderColor3 = C.textDim
    input.TextSize = 11
    input.Font = Enum.Font.Gotham
    input.BorderSizePixel = 0
    input.ClearTextOnFocus = false
    input.Parent = row
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.42, -8, 0, 26)
    btn.Position = UDim2.new(0.58, 4, 0, 24)
    btn.BackgroundColor3 = btnColor or C.neonDim
    btn.Text = btnText or "RUN"
    btn.TextColor3 = C.white
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() cb(input.Text) end)
    return row, input
end

-- ================================================
-- SELECTED TARGET SYSTEM
-- ================================================
local selectedTarget = nil
local targetLabel = Instance.new("TextLabel")
targetLabel.Size = UDim2.new(1, -16, 0, 24)
targetLabel.Position = UDim2.new(0, 8, 0, 0)
targetLabel.BackgroundColor3 = C.bg3
targetLabel.Text = "🎯 Target: Belum dipilih"
targetLabel.TextColor3 = C.neonGlow
targetLabel.TextSize = 11
targetLabel.Font = Enum.Font.GothamBold
targetLabel.BorderSizePixel = 0
Instance.new("UICorner", targetLabel).CornerRadius = UDim.new(0, 8)

local function getTarget(name)
    if name and name ~= "" then
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name:lower():find(name:lower()) and p ~= LocalPlayer then
                return p
            end
        end
    end
    return selectedTarget
end

-- ================================================
-- TAB: PLAYERS (Player List)
-- ================================================
makeSection("Players", "PLAYER LIST — Klik untuk pilih target")
targetLabel.Parent = TabPages["Players"]

local playerListFrame = Instance.new("Frame")
playerListFrame.Size = UDim2.new(1, 0, 0, 0)
playerListFrame.AutomaticSize = Enum.AutomaticSize.Y
playerListFrame.BackgroundColor3 = C.bg2
playerListFrame.BorderSizePixel = 0
playerListFrame.Parent = TabPages["Players"]
Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 10)
local plLayout = Instance.new("UIListLayout")
plLayout.Padding = UDim.new(0, 3)
plLayout.Parent = playerListFrame
local plPad = Instance.new("UIPadding")
plPad.PaddingAll = UDim.new(0, 6)
plPad.Parent = playerListFrame

local playerRows = {}
local function refreshPlayerList()
    for _, r in pairs(playerRows) do r:Destroy() end
    playerRows = {}
    for _, p in ipairs(Players:GetPlayers()) do
        local row = Instance.new("TextButton")
        row.Size = UDim2.new(1, 0, 0, 34)
        row.BackgroundColor3 = p == LocalPlayer and C.bg3 or C.bg
        row.BorderSizePixel = 0
        row.Text = ""
        row.Parent = playerListFrame
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
        local rs = Instance.new("UIStroke", row)
        rs.Color = p == LocalPlayer and C.neon or C.neonDim
        rs.Thickness = 0.5

        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 7, 0, 7)
        dot.Position = UDim2.new(0, 10, 0.5, -3.5)
        dot.BackgroundColor3 = p == LocalPlayer and C.green or C.neon
        dot.BorderSizePixel = 0
        dot.Parent = row
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

        local nl = Instance.new("TextLabel")
        nl.Size = UDim2.new(0.7, 0, 1, 0)
        nl.Position = UDim2.new(0, 22, 0, 0)
        nl.BackgroundTransparency = 1
        nl.Text = (p == LocalPlayer and "[You] " or "") .. p.Name
        nl.TextColor3 = p == LocalPlayer and C.green or C.text
        nl.TextSize = 12
        nl.Font = Enum.Font.GothamBold
        nl.TextXAlignment = Enum.TextXAlignment.Left
        nl.Parent = row

        local selLbl = Instance.new("TextLabel")
        selLbl.Size = UDim2.new(0.3, 0, 1, 0)
        selLbl.Position = UDim2.new(0.7, 0, 0, 0)
        selLbl.BackgroundTransparency = 1
        selLbl.Text = selectedTarget == p and "✔ SELECTED" or ""
        selLbl.TextColor3 = C.neonGlow
        selLbl.TextSize = 10
        selLbl.Font = Enum.Font.GothamBold
        selLbl.TextXAlignment = Enum.TextXAlignment.Right
        selLbl.Parent = row

        if p ~= LocalPlayer then
            row.MouseButton1Click:Connect(function()
                selectedTarget = p
                targetLabel.Text = "🎯 Target: " .. p.Name
                showToast("Target: " .. p.Name, true)
                refreshPlayerList()
            end)
        end
        table.insert(playerRows, row)
    end
end
refreshPlayerList()

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, 0, 0, 28)
refreshBtn.BackgroundColor3 = C.bg3
refreshBtn.Text = "🔄 Refresh"
refreshBtn.TextColor3 = C.neonGlow
refreshBtn.TextSize = 11
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.BorderSizePixel = 0
refreshBtn.Parent = TabPages["Players"]
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 8)
refreshBtn.MouseButton1Click:Connect(refreshPlayerList)

Players.PlayerAdded:Connect(function() task.wait(0.3) refreshPlayerList() end)
Players.PlayerRemoving:Connect(function() task.wait(0.1) refreshPlayerList() end)

-- ================================================
-- TAB: ADMIN
-- ================================================
makeSection("Admin", "TARGET ACTIONS")

-- Kick
makeBtn("Admin", "Kick Player", "Keluarkan target dari server", Color3.fromRGB(153, 27, 27), function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    pcall(function()
        -- Simulasi kick via teleport atau RemoteEvent
        game:GetService("TeleportService"):Teleport(0, t)
    end)
    showToast("Kick: " .. t.Name, true)
end)

-- Freeze
local frozenPlayers = {}
makeBtn("Admin", "Freeze Player", "Bekukan target di tempat", C.neonDim, function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    local char = t.Character
    if not char then return end
    if frozenPlayers[t] then
        frozenPlayers[t]:Disconnect()
        frozenPlayers[t] = nil
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 hum.JumpPower = 50 end
        showToast("Unfreeze: " .. t.Name, false)
    else
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 0 hum.JumpPower = 0 end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local frozenCF = hrp and hrp.CFrame
        frozenPlayers[t] = RunService.Heartbeat:Connect(function()
            if hrp and hrp.Parent and frozenCF then
                hrp.CFrame = frozenCF
            end
        end)
        showToast("Freeze: " .. t.Name, true)
    end
end)

-- Bring
makeBtn("Admin", "Bring Player", "Tarik target ke posisi kamu", C.neonDim, function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    local myRoot = Character and Character:FindFirstChild("HumanoidRootPart")
    local tRoot = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if myRoot and tRoot then
        tRoot.CFrame = myRoot.CFrame + Vector3.new(2, 0, 0)
        showToast("Bring: " .. t.Name, true)
    end
end)

-- TP to Player
makeBtn("Admin", "TP to Player", "Teleport kamu ke target", C.neonDim, function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    local myRoot = Character and Character:FindFirstChild("HumanoidRootPart")
    local tRoot = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if myRoot and tRoot then
        myRoot.CFrame = tRoot.CFrame + Vector3.new(0, 3, 0)
        showToast("TP to: " .. t.Name, true)
    end
end)

-- God Mode target (local)
makeBtn("Admin", "God Mode (Local)", "Buat target tidak bisa mati (lokal)", C.neonDim, function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    local hum = t.Character and t.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Health = hum.MaxHealth
        showToast("God: " .. t.Name, true)
    end
end)

makeSection("Admin", "SERVER ACTIONS")

-- Spectate
makeBtn("Admin", "Spectate Player", "Ikuti kamera ke target", C.neonDim, function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    local hum = t.Character and t.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = hum
        showToast("Spectate: " .. t.Name, true)
    end
end)

-- Stop Spectate
makeBtn("Admin", "Stop Spectate", "Kembali ke kamera normal", Color3.fromRGB(120, 60, 20), function()
    local myHum = Character and Character:FindFirstChildOfClass("Humanoid")
    Camera.CameraType = Enum.CameraType.Custom
    Camera.CameraSubject = myHum
    showToast("Spectate OFF", false)
end)

-- Announce (local only)
makeInputBtn("Admin", "📢 Announce (Local)", "Tulis pesan...", "SEND", C.neonDim, function(msg)
    if msg == "" then return end
    local toast = Instance.new("Frame")
    toast.Size = UDim2.new(0.7, 0, 0, 50)
    toast.Position = UDim2.new(0.15, 0, 0, 80)
    toast.BackgroundColor3 = C.bg2
    toast.BorderSizePixel = 0
    toast.Parent = ScreenGui
    Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 12)
    local ts2 = Instance.new("UIStroke", toast)
    ts2.Color = C.neon
    ts2.Thickness = 2
    local lbl2 = Instance.new("TextLabel")
    lbl2.Size = UDim2.new(1, -20, 1, 0)
    lbl2.Position = UDim2.new(0, 10, 0, 0)
    lbl2.BackgroundTransparency = 1
    lbl2.Text = "📢 [ADMIN]: " .. msg
    lbl2.TextColor3 = C.neonGlow
    lbl2.TextSize = 14
    lbl2.Font = Enum.Font.GothamBold
    lbl2.TextXAlignment = Enum.TextXAlignment.Center
    lbl2.TextWrapped = true
    lbl2.Parent = toast
    task.delay(4, function() toast:Destroy() end)
    showToast("Announce terkirim", true)
end)

-- ================================================
-- TAB: TROLL
-- ================================================
makeSection("Troll", "TROLL ACTIONS — Target wajib dipilih dulu")

-- Fling
makeBtn("Troll", "Fling Player", "Lempar target jauh", Color3.fromRGB(153, 27, 27), function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    local hrp = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        pcall(function()
            hrp.AssemblyLinearVelocity = Vector3.new(
                math.random(-300, 300),
                math.random(200, 500),
                math.random(-300, 300)
            )
        end)
        showToast("Fling: " .. t.Name, true)
    end
end)

-- Spin
local spinConns = {}
makeBtn("Troll", "Spin Player", "Putar target terus-menerus", C.neonDim, function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    if spinConns[t] then
        spinConns[t]:Disconnect()
        spinConns[t] = nil
        showToast("Stop Spin: " .. t.Name, false)
        return
    end
    local hrp = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local angle = 0
    spinConns[t] = RunService.Heartbeat:Connect(function()
        local char = t.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            angle = angle + 15
            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(angle), 0)
        end
    end)
    showToast("Spin: " .. t.Name, true)
end)

-- Jail (trap in invisible box)
local jailParts = {}
makeBtn("Troll", "Jail Player", "Kurung target di tempat", Color3.fromRGB(120, 60, 20), function()
    local t = selectedTarget
    if not t then showToast("Pilih target dulu!", false) return end
    if jailParts[t] then
        for _, p in pairs(jailParts[t]) do p:Destroy() end
        jailParts[t] = nil
        showToast("Unjail: " .. t.Name, false)
        return
    end
    local hrp = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local pos = hrp.Position
    local walls = {
        {Vector3.new(pos.X, pos.Y, pos.Z + 4),   Vector3.new(6, 10, 0.5)},
        {Vector3.new(pos.X, pos.Y, pos.Z - 4),   Vector3.new(6, 10, 0.5)},
        {Vector3.new(pos.X + 3, pos.Y, pos.Z),   Vector3.new(0.5, 10, 8)},
        {Vector3.new(pos.X - 3, pos.Y, pos.Z),   Vector3.new(0.5, 10, 8)},
        {Vector3.new(pos.X, pos.Y + 5, pos.Z),   Vector3.new(6, 0.5, 8)},
    }
    jailParts[t] = {}
    for _, w in ipairs(walls) do
        local p = Instance.new("Part")
        p.Size = w[2]
        p.Position = w[1]
        p.Anchored = true
        p.CanCollide = true
        p.Transparency = 0.7
        p.BrickColor = BrickColor.new("Bright green")
        p.Material = Enum.Material.Neon
        p.Parent = workspace
        table.insert(jailParts[t], p)
    end
    showToast("Jail: " .. t.Name, true)
end)

-- Invisible Crash (infinite loop yield attempt — client side only)
makeBtn("Troll", "Lag Player (Local)", "Bikin layar lu lag sebentar", Color3.fromRGB(90, 20, 90), function()
    showToast("Lag spike dimulai...", true)
    task.spawn(function()
        local startTime = tick()
        while tick() - startTime < 2 do
            for i = 1, 5000 do local _ = math.sqrt(i) end
        end
        showToast("Lag spike selesai", false)
    end)
end)

makeSection("Troll", "CHAT TROLL")

-- Chat Spam
makeInputBtn("Troll", "💬 Chat Spam", "Pesan spam...", "SPAM", Color3.fromRGB(90, 20, 90), function(msg)
    if msg == "" then return end
    task.spawn(function()
        for i = 1, 10 do
            pcall(function()
                game:GetService("ReplicatedStorage")
                    :FindFirstChild("DefaultChatSystemChatEvents")
                    :FindFirstChild("SayMessageRequest")
                    :FireServer(msg, "All")
            end)
            task.wait(0.5)
        end
    end)
    showToast("Chat spam dikirim", true)
end)

-- Chat Troll messages
makeSection("Troll", "QUICK CHAT TROLL")

local trollMessages = {
    "🔴 [SYSTEM]: Server akan direstart dalam 30 detik!",
    "⚠️ [ADMIN]: Semua player akan dikick dalam 10 detik!",
    "🎉 Player " .. LocalPlayer.Name .. " mendapat hadiah Robux gratis!",
    "💀 HACKED BY VERON",
    "🚨 EMERGENCY: Server ini tidak aman!",
}

for _, tmsg in ipairs(trollMessages) do
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, 34)
    row.BackgroundColor3 = C.bg2
    row.BorderSizePixel = 0
    row.Text = ""
    row.Parent = TabPages["Troll"]
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
    local rs = Instance.new("UIStroke", row)
    rs.Color = C.neonDim
    rs.Thickness = 0.5

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = tmsg:sub(1, 45) .. (tmsg:len() > 45 and "..." or "")
    lbl.TextColor3 = C.text
    lbl.TextSize = 10
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextTruncate = Enum.TextTruncate.AtEnd
    lbl.Parent = row

    local sendBtn = Instance.new("TextButton")
    sendBtn.Size = UDim2.new(0, 60, 0, 24)
    sendBtn.Position = UDim2.new(1, -68, 0.5, -12)
    sendBtn.BackgroundColor3 = C.neonDim
    sendBtn.Text = "Send"
    sendBtn.TextColor3 = C.white
    sendBtn.TextSize = 11
    sendBtn.Font = Enum.Font.GothamBold
    sendBtn.BorderSizePixel = 0
    sendBtn.Parent = row
    Instance.new("UICorner", sendBtn).CornerRadius = UDim.new(0, 6)
    sendBtn.MouseButton1Click:Connect(function()
        pcall(function()
            game:GetService("ReplicatedStorage")
                :FindFirstChild("DefaultChatSystemChatEvents")
                :FindFirstChild("SayMessageRequest")
                :FireServer(tmsg, "All")
        end)
        showToast("Chat terkirim!", true)
    end)
end

-- ================================================
-- TAB: FAKE ADMIN
-- ================================================
makeSection("Fake Admin", "FAKE ADMIN PANEL")

local fakeAdminActive = false
local fakeAdminGui = nil

makeBtn("Fake Admin", "Show Fake Admin Panel", "Tampilkan UI palsu seperti admin", C.neonDim, function()
    if fakeAdminGui then fakeAdminGui:Destroy() fakeAdminGui = nil end

    fakeAdminGui = Instance.new("ScreenGui")
    fakeAdminGui.Name = "FakeAdminGui"
    fakeAdminGui.ResetOnSpawn = false
    fakeAdminGui.Parent = VERON_PARENT

    local faBg = Instance.new("Frame")
    faBg.Size = UDim2.new(0, 360, 0, 400)
    faBg.Position = UDim2.new(0.5, -180, 0.5, -200)
    faBg.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    faBg.BorderSizePixel = 0
    faBg.Active = true
    faBg.Draggable = true
    faBg.Parent = fakeAdminGui
    Instance.new("UICorner", faBg).CornerRadius = UDim.new(0, 14)
    local faS = Instance.new("UIStroke", faBg)
    faS.Color = Color3.fromRGB(59, 130, 246)
    faS.Thickness = 2

    local faTB = Instance.new("Frame")
    faTB.Size = UDim2.new(1, 0, 0, 44)
    faTB.BackgroundColor3 = Color3.fromRGB(20, 30, 60)
    faTB.BorderSizePixel = 0
    faTB.Parent = faBg
    Instance.new("UICorner", faTB).CornerRadius = UDim.new(0, 14)

    local faTL = Instance.new("TextLabel")
    faTL.Size = UDim2.new(1, -50, 1, 0)
    faTL.Position = UDim2.new(0, 14, 0, 0)
    faTL.BackgroundTransparency = 1
    faTL.Text = "🛡️  ADMIN PANEL  |  " .. LocalPlayer.Name
    faTL.TextColor3 = Color3.fromRGB(147, 197, 253)
    faTL.TextSize = 13
    faTL.Font = Enum.Font.GothamBold
    faTL.TextXAlignment = Enum.TextXAlignment.Left
    faTL.Parent = faTB

    local faClose = Instance.new("TextButton")
    faClose.Size = UDim2.new(0, 28, 0, 28)
    faClose.Position = UDim2.new(1, -36, 0.5, -14)
    faClose.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
    faClose.Text = "✕"
    faClose.TextColor3 = Color3.fromRGB(248, 113, 113)
    faClose.TextSize = 13
    faClose.Font = Enum.Font.GothamBold
    faClose.BorderSizePixel = 0
    faClose.Parent = faTB
    Instance.new("UICorner", faClose).CornerRadius = UDim.new(0, 6)
    faClose.MouseButton1Click:Connect(function() fakeAdminGui:Destroy() fakeAdminGui = nil end)

    local fakeCommands = {
        {"🚫 Kick All", "Keluarkan semua player"},
        {"🔇 Mute All", "Bisukan semua chat"},
        {"⚡ Speed All", "Speed 100 semua player"},
        {"🌙 Night Mode", "Ubah waktu jadi malam"},
        {"🔒 Lock Server", "Kunci server dari player baru"},
        {"💣 Explode All", "Ledakkan semua player"},
        {"🎭 Shutdown", "Matikan server"},
        {"👁️ Spy Mode", "Pantau semua player"},
    }

    local faScroll = Instance.new("ScrollingFrame")
    faScroll.Size = UDim2.new(1, -16, 1, -54)
    faScroll.Position = UDim2.new(0, 8, 0, 50)
    faScroll.BackgroundTransparency = 1
    faScroll.BorderSizePixel = 0
    faScroll.ScrollBarThickness = 3
    faScroll.ScrollBarImageColor3 = Color3.fromRGB(59, 130, 246)
    faScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    faScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    faScroll.Parent = faBg
    local faL = Instance.new("UIListLayout")
    faL.Padding = UDim.new(0, 6)
    faL.Parent = faScroll
    local faPad = Instance.new("UIPadding")
    faPad.PaddingTop = UDim.new(0, 4)
    faPad.Parent = faScroll

    for _, cmd in ipairs(fakeCommands) do
        local cmdRow = Instance.new("Frame")
        cmdRow.Size = UDim2.new(1, 0, 0, 44)
        cmdRow.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
        cmdRow.BorderSizePixel = 0
        cmdRow.Parent = faScroll
        Instance.new("UICorner", cmdRow).CornerRadius = UDim.new(0, 8)
        local cmdS = Instance.new("UIStroke", cmdRow)
        cmdS.Color = Color3.fromRGB(59, 130, 246)
        cmdS.Thickness = 0.5

        local cmdLbl = Instance.new("TextLabel")
        cmdLbl.Size = UDim2.new(1, -80, 0, 20)
        cmdLbl.Position = UDim2.new(0, 12, 0, 6)
        cmdLbl.BackgroundTransparency = 1
        cmdLbl.Text = cmd[1]
        cmdLbl.TextColor3 = Color3.fromRGB(200, 220, 255)
        cmdLbl.TextSize = 12
        cmdLbl.Font = Enum.Font.GothamBold
        cmdLbl.TextXAlignment = Enum.TextXAlignment.Left
        cmdLbl.Parent = cmdRow

        local cmdSub = Instance.new("TextLabel")
        cmdSub.Size = UDim2.new(1, -80, 0, 14)
        cmdSub.Position = UDim2.new(0, 12, 0, 26)
        cmdSub.BackgroundTransparency = 1
        cmdSub.Text = cmd[2]
        cmdSub.TextColor3 = Color3.fromRGB(80, 120, 180)
        cmdSub.TextSize = 10
        cmdSub.Font = Enum.Font.Gotham
        cmdSub.TextXAlignment = Enum.TextXAlignment.Left
        cmdSub.Parent = cmdRow

        local cmdBtn = Instance.new("TextButton")
        cmdBtn.Size = UDim2.new(0, 64, 0, 26)
        cmdBtn.Position = UDim2.new(1, -72, 0.5, -13)
        cmdBtn.BackgroundColor3 = Color3.fromRGB(29, 78, 216)
        cmdBtn.Text = "EXECUTE"
        cmdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        cmdBtn.TextSize = 10
        cmdBtn.Font = Enum.Font.GothamBold
        cmdBtn.BorderSizePixel = 0
        cmdBtn.Parent = cmdRow
        Instance.new("UICorner", cmdBtn).CornerRadius = UDim.new(0, 6)

        -- Fake loading effect
        cmdBtn.MouseButton1Click:Connect(function()
            cmdBtn.Text = "..."
            cmdBtn.BackgroundColor3 = Color3.fromRGB(21, 128, 61)
            task.delay(1.5, function()
                cmdBtn.Text = "✔ DONE"
                task.delay(2, function()
                    cmdBtn.Text = "EXECUTE"
                    cmdBtn.BackgroundColor3 = Color3.fromRGB(29, 78, 216)
                end)
            end)
        end)
    end

    showToast("Fake Admin Panel dibuka", true)
end)

makeSection("Fake Admin", "FAKE NOTIFICATION")

makeInputBtn("Fake Admin", "📨 Fake System Notif", "Tulis pesan sistem palsu...", "SEND", C.neonDim, function(msg)
    if msg == "" then return end
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 320, 0, 60)
    notif.Position = UDim2.new(0.5, -160, 0, -70)
    notif.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)
    local ns = Instance.new("UIStroke", notif)
    ns.Color = Color3.fromRGB(59, 130, 246)
    ns.Thickness = 2

    local nl2 = Instance.new("TextLabel")
    nl2.Size = UDim2.new(1, -20, 0.5, 0)
    nl2.Position = UDim2.new(0, 10, 0, 2)
    nl2.BackgroundTransparency = 1
    nl2.Text = "🛡️ ROBLOX SYSTEM"
    nl2.TextColor3 = Color3.fromRGB(59, 130, 246)
    nl2.TextSize = 11
    nl2.Font = Enum.Font.GothamBold
    nl2.TextXAlignment = Enum.TextXAlignment.Left
    nl2.Parent = notif

    local nl3 = Instance.new("TextLabel")
    nl3.Size = UDim2.new(1, -20, 0.5, 0)
    nl3.Position = UDim2.new(0, 10, 0.5, 0)
    nl3.BackgroundTransparency = 1
    nl3.Text = msg
    nl3.TextColor3 = Color3.fromRGB(200, 220, 255)
    nl3.TextSize = 12
    nl3.Font = Enum.Font.Gotham
    nl3.TextXAlignment = Enum.TextXAlignment.Left
    nl3.TextWrapped = true
    nl3.Parent = notif

    TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -160, 0, 12)
    }):Play()
    task.delay(4, function()
        TweenService:Create(notif, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -160, 0, -70)
        }):Play()
        task.wait(0.35)
        notif:Destroy()
    end)
    showToast("Notif terkirim", true)
end)

makeSection("Fake Admin", "FAKE RANK BADGE")

makeBtn("Fake Admin", "Show Fake Admin Badge", "Pasang badge Admin di atas kepala", C.neonDim, function()
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local hrp = myChar:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if hrp:FindFirstChild("FakeAdminBadge") then
        hrp:FindFirstChild("FakeAdminBadge"):Destroy()
        showToast("Badge dicopot", false)
        return
    end
    local bb = Instance.new("BillboardGui")
    bb.Name = "FakeAdminBadge"
    bb.Size = UDim2.new(0, 120, 0, 28)
    bb.StudsOffset = Vector3.new(0, 3.5, 0)
    bb.AlwaysOnTop = true
    bb.Adornee = hrp
    bb.Parent = hrp

    local bg2 = Instance.new("Frame")
    bg2.Size = UDim2.new(1, 0, 1, 0)
    bg2.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    bg2.BorderSizePixel = 0
    bg2.Parent = bb
    Instance.new("UICorner", bg2).CornerRadius = UDim.new(0, 6)
    local bs2 = Instance.new("UIStroke", bg2)
    bs2.Color = Color3.fromRGB(59, 130, 246)
    bs2.Thickness = 1.5

    local bl = Instance.new("TextLabel")
    bl.Size = UDim2.new(1, 0, 1, 0)
    bl.BackgroundTransparency = 1
    bl.Text = "🛡️ SERVER ADMIN"
    bl.TextColor3 = Color3.fromRGB(147, 197, 253)
    bl.TextSize = 11
    bl.Font = Enum.Font.GothamBold
    bl.TextXAlignment = Enum.TextXAlignment.Center
    bl.Parent = bg2

    showToast("Badge Admin dipasang", true)
end)

-- ================================================
-- KEYBIND
-- ================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
        OpenBtn.Visible = not MainFrame.Visible
    end
end)

-- ================================================
-- RESPAWN HANDLER
-- ================================================
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
end)

print("✅ VERON ADMIN+TROLL HUB v1.0 | Dev: veron2high")
print("   RightCtrl = hide/show UI")
print("   Key: VERON-ADMIN")
