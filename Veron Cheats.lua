-- All Source Made By Veron
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- All Source Made By Veron
local Config = {
    KillAura_Enabled = false,
    KillAura_Range = 15,
    Hitbox_Enabled = false,
    Hitbox_Size = 15,
    
    InfiniteStamina = false,
    NoRecoil = false,
    NoSpread = false,
    
    ESP_Players = false,
    ESP_Items = false,
    Fullbright = false,
    
    Speed_Enabled = false,
    Speed_Value = 2,
    Fly_Enabled = false,
    Fly_Speed = 60,
    Noclip_Enabled = false,
    InfiniteJump = true,
    AntiRagdoll = true,
    
    AutoCollect = false,
    AutoCollect_Range = 30,
}

-- UI Made By Veron
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Veron_" .. math.random(1000, 9999)
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 120, 0, 35)
OpenBtn.Position = UDim2.new(0, 15, 0, 15)
OpenBtn.BackgroundColor3 = Color3.fromRGB(35, 10, 15)
OpenBtn.Text = "VERON HUB"
OpenBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
OpenBtn.TextSize = 12
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
local OCorner = Instance.new("UICorner") OCorner.CornerRadius = UDim.new(0, 6) OCorner.Parent = OpenBtn

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 460)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 8) MainCorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 5, 10)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TitleCorner = Instance.new("UICorner") TitleCorner.CornerRadius = UDim.new(0, 8) TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "VERON HUB [Veron]"
TitleLabel.Size = UDim2.new(1, -35, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -20, 0, 30)
TabFrame.Position = UDim2.new(0, 10, 0, 45)
TabFrame.BackgroundColor3 = Color3.fromRGB(30, 8, 12)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame
local TabCorner = Instance.new("UICorner") TabCorner.CornerRadius = UDim.new(0, 6) TabCorner.Parent = TabFrame

local Tabs = {"Combat", "Visuals", "Movement"} 
local TabButtons = {} 
local TabContents = {}

for i, tabName in ipairs(Tabs) do 
    local btn = Instance.new("TextButton") 
    btn.Size = UDim2.new(0.33, -2, 1, -4) 
    btn.Position = UDim2.new(0, (i-1)*103 + 2, 0, 2) 
    btn.BackgroundColor3 = Color3.fromRGB(50, 15, 20) 
    btn.Text = tabName 
    btn.TextColor3 = Color3.fromRGB(200, 150, 150) 
    btn.TextSize = 11 
    btn.Font = Enum.Font.GothamBold 
    btn.BorderSizePixel = 0 
    btn.Parent = TabFrame 
    TabButtons[tabName] = btn 
    local bCorner = Instance.new("UICorner") bCorner.CornerRadius = UDim.new(0, 4) bCorner.Parent = btn
    
    local content = Instance.new("ScrollingFrame") 
    content.Size = UDim2.new(1, -20, 1, -90) 
    content.Position = UDim2.new(0, 10, 0, 85) 
    content.BackgroundTransparency = 1 
    content.BorderSizePixel = 0 
    content.ScrollBarThickness = 3 
    content.Visible = i == 1 
    content.CanvasSize = UDim2.new(0, 0, 0, 0) 
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y 
    content.Parent = MainFrame 
    TabContents[tabName] = content 
    local layout = Instance.new("UIListLayout") layout.Padding = UDim.new(0, 6) layout.Parent = content 
end

-- All Source Made By Veron
local function SwitchTab(tabName) 
    for name, content in pairs(TabContents) do 
        content.Visible = name == tabName 
        TabButtons[name].BackgroundColor3 = name == tabName and Color3.fromRGB(80, 20, 30) or Color3.fromRGB(50, 15, 20) 
    end 
end 
for name, btn in pairs(TabButtons) do btn.MouseButton1Click:Connect(function() SwitchTab(name) end) end

local function CreateToggle(tabName, text, configKey) 
    local btn = Instance.new("TextButton") 
    btn.Size = UDim2.new(1, 0, 0, 32) 
    btn.BackgroundColor3 = Color3.fromRGB(45, 15, 20) 
    btn.Text = "  " .. text .. ": OFF" 
    btn.TextColor3 = Color3.fromRGB(255, 80, 80) 
    btn.TextSize = 12 
    btn.Font = Enum.Font.Gotham 
    btn.TextXAlignment = Enum.TextXAlignment.Left 
    btn.Parent = TabContents[tabName] 
    local corner = Instance.new("UICorner", btn) corner.CornerRadius = UDim.new(0, 5) 
    btn.MouseButton1Click:Connect(function() 
        Config[configKey] = not Config[configKey] 
        btn.Text = "  " .. text .. (Config[configKey] and ": ON" or ": OFF") 
        btn.TextColor3 = Config[configKey] and Color3.fromRGB(80, 255, 180) or Color3.fromRGB(255, 80, 80) 
    end) 
end

local function CreateSlider(tabName, text, configKey, min, max) 
    local frame = Instance.new("Frame") 
    frame.Size = UDim2.new(1, 0, 0, 40) 
    frame.BackgroundColor3 = Color3.fromRGB(45, 15, 20) 
    frame.BorderSizePixel = 0 
    frame.Parent = TabContents[tabName] 
    local corner = Instance.new("UICorner", frame) corner.CornerRadius = UDim.new(0, 5) 
    local label = Instance.new("TextLabel", frame) 
    label.Size = UDim2.new(1, -10, 0, 15) 
    label.Position = UDim2.new(0, 10, 0, 2) 
    label.BackgroundTransparency = 1 
    label.Text = text .. ": " .. Config[configKey] 
    label.TextColor3 = Color3.fromRGB(200, 180, 180) 
    label.TextSize = 11 
    label.Font = Enum.Font.Gotham 
    label.TextXAlignment = Enum.TextXAlignment.Left 
    local sliderBar = Instance.new("Frame", frame) 
    sliderBar.Size = UDim2.new(0.9, 0, 0, 6) 
    sliderBar.Position = UDim2.new(0.05, 0, 0, 25) 
    sliderBar.BackgroundColor3 = Color3.fromRGB(30, 8, 12) 
    sliderBar.BorderSizePixel = 0 
    local sCorner = Instance.new("UICorner", sliderBar) sCorner.CornerRadius = UDim.new(0, 3) 
    local fill = Instance.new("Frame") 
    fill.Size = UDim2.new((Config[configKey]-min)/(max-min), 0, 1, 0) 
    fill.BackgroundColor3 = Color3.fromRGB(255, 50, 50) 
    fill.BorderSizePixel = 0 
    fill.Parent = sliderBar 
    local fCorner = Instance.new("UICorner", fill) fCorner.CornerRadius = UDim.new(0, 3) 
    local draggingSlider = false 
    local inputDetector = Instance.new("TextButton") 
    inputDetector.Size = UDim2.new(1, 0, 1, 0) 
    inputDetector.BackgroundTransparency = 1 
    inputDetector.Text = "" 
    inputDetector.Parent = sliderBar 
    inputDetector.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true end end) 
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end end) 
    UserInputService.InputChanged:Connect(function(input) if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then local relX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1) fill.Size = UDim2.new(relX, 0, 1, 0) local val = min + (max - min) * relX Config[configKey] = math.floor(val * 10) / 10 label.Text = text .. ": " .. Config[configKey] end end) 
end

-- Tabs Setup By Veron
CreateToggle("Combat", "Kill Aura (Melee)", "KillAura_Enabled") CreateSlider("Combat", "Aura Range", "KillAura_Range", 5, 30)
CreateToggle("Combat", "Hitbox Expander", "Hitbox_Enabled") CreateSlider("Combat", "Hitbox Size", "Hitbox_Size", 5, 25)
CreateToggle("Combat", "Anti Ragdoll", "AntiRagdoll")
CreateToggle("Combat", "Infinite Stamina", "InfiniteStamina")
CreateToggle("Combat", "No Recoil (Guns)", "NoRecoil")
CreateToggle("Combat", "No Spread (Guns)", "NoSpread")
CreateToggle("Combat", "Auto Collect Money", "AutoCollect") CreateSlider("Combat", "Collect Range", "AutoCollect_Range", 10, 60)

CreateToggle("Visuals", "ESP Players", "ESP_Players") CreateToggle("Visuals", "ESP Money/Items", "ESP_Items")
CreateToggle("Visuals", "Fullbright", "Fullbright")

CreateToggle("Movement", "CFrame Speed", "Speed_Enabled") CreateSlider("Movement", "Speed Multiplier", "Speed_Value", 1.1, 4)
CreateToggle("Movement", "CFrame Fly", "Fly_Enabled") CreateSlider("Movement", "Fly Speed", "Fly_Speed", 20, 80)
CreateToggle("Movement", "Noclip (Walls)", "Noclip_Enabled")
CreateToggle("Movement", "Infinite Jump", "InfiniteJump")

-- All Source Made By Veron
local draggingMenu, dragStartMenu, startPosMenu 
TitleBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingMenu = true dragStartMenu = input.Position startPosMenu = MainFrame.Position end end) 
TitleBar.InputChanged:Connect(function(input) if draggingMenu and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - dragStartMenu MainFrame.Position = UDim2.new(startPosMenu.X.Scale, startPosMenu.X.Offset + delta.X, startPosMenu.Y.Scale, startPosMenu.Y.Offset + delta.Y) end end) 
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingMenu = false end end)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenBtn.Visible = true end) 
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenBtn.Visible = false end)
UserInputService.InputBegan:Connect(function(input, gp) if gp then return end if input.KeyCode == Enum.KeyCode.RightShift then MainFrame.Visible = not MainFrame.Visible OpenBtn.Visible = not MainFrame.Visible end end)

-- Logic By Veron
local ESPPlayerObjects = {} local ESPItemObjects = {}
local originalLighting = { Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime, FogEnd = Lighting.FogEnd, GlobalShadows = Lighting.GlobalShadows }

-- Kill Aura
task.spawn(function()
    while task.wait(0.3) do
        if Config.KillAura_Enabled then
            local char = LocalPlayer.Character local root = char and char:FindFirstChild("HumanoidRootPart") local hum = char and char:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health > 0 then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid") then
                            local tHum = player.Character:FindFirstChildOfClass("Humanoid")
                            local dist = (player.Character.HumanoidRootPart.Position - root.Position).Magnitude
                            if dist <= Config.KillAura_Range and tHum.Health > 0 then
                                tool:Activate()
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Collect Money (Vacuum)
task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoCollect then
            local char = LocalPlayer.Character local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (string.find(obj.Name:lower(), "money") or string.find(obj.Name:lower(), "cash") or string.find(obj.Name:lower(), "drop")) then
                        local dist = (obj.Position - root.Position).Magnitude
                        if dist <= Config.AutoCollect_Range then
                            obj.CFrame = root.CFrame
                        end
                    end
                end
            end
        end
    end
end)

-- Hitbox Logic
local function UpdateHitboxes() 
    for player, _ in pairs(ESPPlayerObjects) do 
        if player ~= LocalPlayer and player.Character then 
            local character = player.Character 
            local head = character:FindFirstChild("Head") 
            local root = character:FindFirstChild("HumanoidRootPart") 
            if head and head:IsA("BasePart") then 
                if Config.Hitbox_Enabled then 
                    head.Size = Vector3.new(Config.Hitbox_Size, Config.Hitbox_Size, Config.Hitbox_Size) head.Transparency = 0.7 head.CanCollide = false head.Massless = true 
                else 
                    head.Size = Vector3.new(1.2, 1.2, 1.2) head.Transparency = 0 
                end 
            end 
            if root and root:IsA("BasePart") then 
                if Config.Hitbox_Enabled then 
                    root.Size = Vector3.new(Config.Hitbox_Size, Config.Hitbox_Size, Config.Hitbox_Size) root.Transparency = 1 root.CanCollide = false root.Massless = true 
                else 
                    root.Size = Vector3.new(2, 2, 1) root.Transparency = 1 
                end 
            end 
        end 
    end 
end

-- Anti-Ragdoll & Infinite Stamina
local function SurvivalBypass()
    local char = LocalPlayer.Character
    if char then
        if Config.AntiRagdoll then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BallSocketConstraint") or v:IsA("HingeConstraint") then v.Enabled = false end
                if v.Name:lower():find("ragdoll") and v:IsA("BoolValue") then v.Value = false end
            end
        end
        if Config.InfiniteStamina then
            for _, v in pairs(char:GetDescendants()) do
                if (v.Name:lower():find("stam") or v.Name:lower():find("ener")) and (v:IsA("NumberValue") or v:IsA("IntValue")) then
                    v.Value = 100
                end
            end
        end
    end
end

-- Gun Mods
local function ModifyGuns()
    if not Config.NoRecoil and not Config.NoSpread then return end
    local function ModTool(tool)
        if tool:IsA("Tool") then
            for _, v in pairs(tool:GetDescendants()) do
                if v:IsA("ValueBase") then
                    if Config.NoRecoil and (v.Name:lower():find("recoil") or v.Name:lower():find("kick")) then v.Value = 0 end
                    if Config.NoSpread and (v.Name:lower():find("spread") or v.Name:lower():find("accuracy")) then v.Value = 0 end
                end
            end
        end
    end
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if backpack then for _, tool in pairs(backpack:GetChildren()) do ModTool(tool) end end
    local char = LocalPlayer.Character if char then local tool = char:FindFirstChildOfClass("Tool") if tool then ModTool(tool) end end
end

-- Movement Logic
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character local root = char and char:FindFirstChild("HumanoidRootPart") local hum = char and char:FindFirstChildOfClass("Humanoid")
    if root and hum then
        if Config.Speed_Enabled and hum.Health > 0 and hum.MoveDirection.Magnitude > 0 then root.CFrame = root.CFrame + (hum.MoveDirection * (Config.Speed_Value - 1)) end
        if Config.Fly_Enabled then 
            hum.PlatformStand = true local cam = workspace.CurrentCamera local moveDir = Vector3.new(0,0,0) 
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end 
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end 
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end 
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end 
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end 
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0,1,0) end 
            root.CFrame = root.CFrame + (moveDir * Config.Fly_Speed * 0.016) root.Velocity = Vector3.new(0,0,0) 
        else 
            if hum.PlatformStand then hum.PlatformStand = false end 
        end
        if Config.Noclip_Enabled then for _, part in pairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
    end
    UpdateHitboxes() SurvivalBypass() ModifyGuns()
    
    if Config.Fullbright then Lighting.Brightness = 2 Lighting.ClockTime = 14 Lighting.FogEnd = 100000 Lighting.GlobalShadows = false else Lighting.Brightness = originalLighting.Brightness Lighting.ClockTime = originalLighting.ClockTime Lighting.FogEnd = originalLighting.FogEnd Lighting.GlobalShadows = originalLighting.GlobalShadows end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function() if Config.InfiniteJump then local char = LocalPlayer.Character local hum = char and char:FindFirstChildOfClass("Humanoid") if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end end end)

-- ESP Logic
local function UpdateVisuals()
    for _, player in pairs(Players:GetPlayers()) do 
        if player ~= LocalPlayer then 
            local data = ESPPlayerObjects[player]
            if Config.ESP_Players and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if not data then 
                    data = {} 
                    data.Box = Drawing.new("Square") data.Box.Thickness = 1 data.Box.Filled = false data.Box.Color = Color3.fromRGB(255, 50, 50) 
                    data.Name = Drawing.new("Text") data.Name.Center = true data.Name.Outline = true data.Name.Size = 13 data.Name.Font = 2 data.Name.Color = Color3.fromRGB(255, 255, 255) 
                    ESPPlayerObjects[player] = data 
                end
                local hrp = player.Character.HumanoidRootPart local hum = player.Character:FindFirstChildOfClass("Humanoid") local head = player.Character:FindFirstChild("Head")
                if hum and hum.Health > 0 and head then 
                    local headPos, headVis = workspace.CurrentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0)) local footPos, footVis = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)) 
                    if headVis or footVis then 
                        local height = math.abs(headPos.Y - footPos.Y) local width = height * 0.6 data.Box.Size = Vector2.new(width, height) data.Box.Position = Vector2.new(footPos.X - width/2, headPos.Y) data.Box.Visible = true data.Name.Position = Vector2.new(footPos.X, headPos.Y - 15) data.Name.Text = player.Name data.Name.Visible = true 
                    else 
                        data.Box.Visible = false data.Name.Visible = false 
                    end
                else 
                    if data then data.Box.Visible = false data.Name.Visible = false end 
                end
            else 
                if data then data.Box.Visible = false data.Name.Visible = false end 
            end
        end 
    end

    if Config.ESP_Items then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (string.find(obj.Name:lower(), "money") or string.find(obj.Name:lower(), "cash") or string.find(obj.Name:lower(), "drop") or string.find(obj.Name:lower(), "item")) and not ESPItemObjects[obj] then
                local highlight = Instance.new("Highlight") highlight.Name = "Veron_ESP" highlight.FillColor = Color3.fromRGB(255, 255, 0) highlight.OutlineColor = Color3.fromRGB(255, 255, 255) highlight.FillTransparency = 0.5 highlight.Parent = obj ESPItemObjects[obj] = highlight
            end
        end
    else 
        for obj, esp in pairs(ESPItemObjects) do if esp then esp:Destroy() end end ESPItemObjects = {} 
    end
end

RunService.RenderStepped:Connect(UpdateVisuals)
local VirtualUser = game:GetService("VirtualUser") LocalPlayer.Idled:Connect(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end)