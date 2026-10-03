-- SATT Universal Script (Delta Supported - Ultimate Edition v6 with Waypoints)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Clean up existing GUI
if CoreGui:FindFirstChild("SATT_Hub") then
    CoreGui.SATT_Hub:Destroy()
end
if CoreGui:FindFirstChild("SATT_FPS") then
    CoreGui.SATT_FPS:Destroy()
end
if CoreGui:FindFirstChild("SATT_MinIcon") then
    CoreGui.SATT_MinIcon:Destroy()
end

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SATT_Hub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Frame (Modern Cyberpunk Gradient & Rounded Corners)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -165)
MainFrame.Size = UDim2.new(0, 480, 0, 330)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 18, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 20, 65))
})
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(150, 80, 255)
MainStroke.Transparency = 0.5
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Top Bar / Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundTransparency = 1
Header.Size = UDim2.new(1, 0, 0, 45)

-- Minecraft Style Logo ("S" Capital, Full Transparent Background)
local LogoHolder = Instance.new("Frame")
LogoHolder.Parent = Header
LogoHolder.BackgroundTransparency = 1
LogoHolder.Position = UDim2.new(0, 12, 0, 5)
LogoHolder.Size = UDim2.new(0, 35, 0, 35)

local LogoLabel = Instance.new("TextLabel")
LogoLabel.Parent = LogoHolder
LogoLabel.BackgroundTransparency = 1
LogoLabel.Size = UDim2.new(1, 0, 1, 0)
LogoLabel.Font = Enum.Font.Arcade
LogoLabel.Text = "S"
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.TextSize = 26
LogoLabel.TextXAlignment = Enum.TextXAlignment.Center
LogoLabel.TextYAlignment = Enum.TextYAlignment.Center

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(0, 0, 0)
logoStroke.Thickness = 2.5
logoStroke.Parent = LogoLabel

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 55, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "SATT // UNIVERSAL"
Title.TextColor3 = Color3.fromRGB(240, 240, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize and Resize Controls
local ControlHolder = Instance.new("Frame")
ControlHolder.Parent = Header
ControlHolder.BackgroundTransparency = 1
ControlHolder.Position = UDim2.new(1, -95, 0, 7)
ControlHolder.Size = UDim2.new(0, 85, 0, 30)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = ControlHolder
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 90)
MinimizeBtn.Position = UDim2.new(0, 0, 0, 0)
MinimizeBtn.Size = UDim2.new(0, 38, 1, 0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
local mCorner = Instance.new("UICorner")
mCorner.CornerRadius = UDim.new(0, 6)
mCorner.Parent = MinimizeBtn

local ResizeBtn = Instance.new("TextButton")
ResizeBtn.Parent = ControlHolder
ResizeBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 90)
ResizeBtn.Position = UDim2.new(0, 45, 0, 0)
ResizeBtn.Size = UDim2.new(0, 38, 1, 0)
ResizeBtn.Font = Enum.Font.GothamBold
ResizeBtn.Text = "[]"
ResizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResizeBtn.TextSize = 11
local rCorner = Instance.new("UICorner")
rCorner.CornerRadius = UDim.new(0, 6)
rCorner.Parent = ResizeBtn

-- Floating Full Transparent Minecraft Logo Minimize Icon
local MinIconGui = Instance.new("ScreenGui")
MinIconGui.Name = "SATT_MinIcon"
MinIconGui.Parent = CoreGui
MinIconGui.ResetOnSpawn = false
MinIconGui.Enabled = false

local MinIconButton = Instance.new("TextButton")
MinIconButton.Parent = MinIconGui
MinIconButton.BackgroundTransparency = 1
MinIconButton.Position = UDim2.new(0, 25, 0.5, -25)
MinIconButton.Size = UDim2.new(0, 45, 0, 45)
MinIconButton.Font = Enum.Font.Arcade
MinIconButton.Text = "S"
MinIconButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinIconButton.TextSize = 34
MinIconButton.Active = true
MinIconButton.Draggable = true

local miTextStroke = Instance.new("UIStroke")
miTextStroke.Color = Color3.fromRGB(0, 0, 0)
miTextStroke.Thickness = 3
miTextStroke.Parent = MinIconButton

-- Minimize / Restore Event Handlers
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinIconGui.Enabled = true
end)

MinIconButton.MouseButton1Click:Connect(function()
    MinIconGui.Enabled = false
    MainFrame.Visible = true
end)

-- Custom Resize Toggle
local isLargeSize = false
local normalSize = UDim2.new(0, 480, 0, 330)
ResizeBtn.MouseButton1Click:Connect(function()
    isLargeSize = not isLargeSize
    if isLargeSize then
        normalSize = UDim2.new(0, 560, 0, 400)
    else
        normalSize = UDim2.new(0, 480, 0, 330)
    end
    MainFrame.Size = normalSize
end)

-- Sidebar / Tabs Setup
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundTransparency = 1
Sidebar.Position = UDim2.new(0, 12, 0, 55)
Sidebar.Size = UDim2.new(0, 115, 0, 260)
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 280)
Sidebar.ScrollBarThickness = 2

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 6)

-- Content Container
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 135, 0, 55)
Container.Size = UDim2.new(1, -145, 1, -65)

local function createTabContent(name)
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = name .. "Content"
    scrollingFrame.Parent = Container
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 750)
    scrollingFrame.ScrollBarThickness = 3
    scrollingFrame.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = scrollingFrame
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    
    return scrollingFrame
end

local Tabs = {"Main", "Waypoint", "Troll", "SmartTP", "Combat", "Settings"}
local TabContents = {}

for i, tabName in ipairs(Tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = tabName .. "Btn"
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(35, 30, 55)
    btn.Size = UDim2.new(1, -5, 0, 34)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.TextSize = 12
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    TabContents[tabName] = createTabContent(tabName)
    
    if i == 1 then
        TabContents[tabName].Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(110, 50, 190)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    btn.MouseButton1Click:Connect(function()
        for _, content in pairs(TabContents) do
            content.Visible = false
        end
        for _, b in pairs(Sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(35, 30, 55)
                b.TextColor3 = Color3.fromRGB(200, 200, 220)
            end
        end
        TabContents[tabName].Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(110, 50, 190)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

-- Helper for Toggles
local function createToggle(parent, title, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
    frame.Size = UDim2.new(1, -10, 0, 42)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(0, 190, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = title
    label.TextColor3 = Color3.fromRGB(230, 230, 245)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBtn.Position = UDim2.new(1, -55, 0.5, -12)
    toggleBtn.Size = UDim2.new(0, 45, 0, 24)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 11
    
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 4)
    tCorner.Parent = toggleBtn
    
    local active = false
    toggleBtn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            toggleBtn.Text = "ON"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            toggleBtn.Text = "OFF"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
        callback(active)
    end)
end

-- ==========================================
-- 1. MAIN TAB (Character Fly, Speed, Inf Jump, etc.)
-- ==========================================
local mainTab = TabContents["Main"]

local flySpeed = 50
local flyActive = false
local bg, bv

createToggle(mainTab, "Character Fly", function(state)
    flyActive = state
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if flyActive then
            if humanoid then humanoid.PlatformStand = true end
            bg = Instance.new("BodyGyro")
            bg.P = 9e4
            bg.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
            bg.CFrame = hrp.CFrame
            bg.Parent = hrp
            
            bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.MaxForce = Vector3.new(9e4, 9e4, 9e4)
            bv.Parent = hrp
            
            task.spawn(function()
                while flyActive and char and hrp.Parent do
                    RunService.RenderStepped:Wait()
                    local cam = workspace.CurrentCamera
                    local moveDir = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
                    
                    bv.Velocity = moveDir * flySpeed
                    bg.CFrame = cam.CFrame
                end
            end)
        else
            if humanoid then humanoid.PlatformStand = false end
            if bg then bg:Destroy() bg = nil end
            if bv then bv:Destroy() bv = nil end
        end
    end
end)

-- Fly Speed Setting Box
local flySpeedFrame = Instance.new("Frame")
flySpeedFrame.Parent = mainTab
flySpeedFrame.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
flySpeedFrame.Size = UDim2.new(1, -10, 0, 42)
local fsCorner = Instance.new("UICorner")
fsCorner.CornerRadius = UDim.new(0, 6)
fsCorner.Parent = flySpeedFrame

local fsLabel = Instance.new("TextLabel")
fsLabel.Parent = flySpeedFrame
fsLabel.BackgroundTransparency = 1
fsLabel.Position = UDim2.new(0, 12, 0, 0)
fsLabel.Size = UDim2.new(0, 190, 1, 0)
fsLabel.Font = Enum.Font.GothamMedium
fsLabel.Text = "Fly Speed (1 - Unlimited)"
fsLabel.TextColor3 = Color3.fromRGB(230, 230, 245)
fsLabel.TextSize = 12
fsLabel.TextXAlignment = Enum.TextXAlignment.Left

local fsBox = Instance.new("TextBox")
fsBox.Parent = flySpeedFrame
fsBox.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
fsBox.Position = UDim2.new(1, -65, 0.5, -12)
fsBox.Size = UDim2.new(0, 55, 0, 24)
fsBox.Font = Enum.Font.GothamBold
fsBox.Text = tostring(flySpeed)
fsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
fsBox.TextSize = 12
local fsbCorner = Instance.new("UICorner")
fsbCorner.CornerRadius = UDim.new(0, 4)
fsbCorner.Parent = fsBox

fsBox.FocusLost:Connect(function()
    local val = tonumber(fsBox.Text)
    if val then
        if val < 1 then val = 1 end
        flySpeed = val
        fsBox.Text = tostring(val)
    else
        fsBox.Text = tostring(flySpeed)
    end
end)

-- Infinite Jump
local infJumpActive = false
local infJumpConn = nil

createToggle(mainTab, "Infinite Jump", function(state)
    infJumpActive = state
    if infJumpActive then
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            if infJumpActive then
                local char = LocalPlayer.Character
                if char then
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end)
    else
        if infJumpConn then
            infJumpConn:Disconnect()
            infJumpConn = nil
        end
    end
end)

-- Vehicle Fly
local vflySpeed = 50
local vflyActive = false

createToggle(mainTab, "Vehicle Fly (All Maps)", function(state)
    vflyActive = state
    task.spawn(function()
        while vflyActive do
            RunService.RenderStepped:Wait()
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                local seatPart = humanoid and humanoid.SeatPart
                if seatPart then
                    seatPart.AssemblyLinearVelocity = Vector3.new(0, 1, 0) * vflySpeed
                    if Camera then
                        seatPart.CFrame = CFrame.new(seatPart.Position, seatPart.Position + Camera.CFrame.LookVector)
                    end
                end
            end
        end
    end)
end)

-- VFly Speed Setting
local speedFrame = Instance.new("Frame")
speedFrame.Parent = mainTab
speedFrame.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
speedFrame.Size = UDim2.new(1, -10, 0, 42)
local sCorner = Instance.new("UICorner")
sCorner.CornerRadius = UDim.new(0, 6)
sCorner.Parent = speedFrame

local sLabel = Instance.new("TextLabel")
sLabel.Parent = speedFrame
sLabel.BackgroundTransparency = 1
sLabel.Position = UDim2.new(0, 12, 0, 0)
sLabel.Size = UDim2.new(0, 190, 1, 0)
sLabel.Font = Enum.Font.GothamMedium
sLabel.Text = "VFly Speed (1-99)"
sLabel.TextColor3 = Color3.fromRGB(230, 230, 245)
sLabel.TextSize = 12
sLabel.TextXAlignment = Enum.TextXAlignment.Left

local sBox = Instance.new("TextBox")
sBox.Parent = speedFrame
sBox.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
sBox.Position = UDim2.new(1, -65, 0.5, -12)
sBox.Size = UDim2.new(0, 55, 0, 24)
sBox.Font = Enum.Font.GothamBold
sBox.Text = tostring(vflySpeed)
sBox.TextColor3 = Color3.fromRGB(255, 255, 255)
sBox.TextSize = 12
local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 4)
sbCorner.Parent = sBox

sBox.FocusLost:Connect(function()
    local val = tonumber(sBox.Text)
    if val then
        if val < 1 then val = 1 end
        if val > 99 then val = 99 end
        vflySpeed = val
        sBox.Text = tostring(val)
    else
        sBox.Text = tostring(vflySpeed)
    end
end)

-- Speed Boost (1 - 2000)
local speedBoostValue = 16
local speedBoostActive = false

createToggle(mainTab, "Speed Boost (1-2000)", function(state)
    speedBoostActive = state
end)

local sbFrame = Instance.new("Frame")
sbFrame.Parent = mainTab
sbFrame.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
sbFrame.Size = UDim2.new(1, -10, 0, 42)
local sbC = Instance.new("UICorner")
sbC.CornerRadius = UDim.new(0, 6)
sbC.Parent = sbFrame

local sbLbl = Instance.new("TextLabel")
sbLbl.Parent = sbFrame
sbLbl.BackgroundTransparency = 1
sbLbl.Position = UDim2.new(0, 12, 0, 0)
sbLbl.Size = UDim2.new(0, 190, 1, 0)
sbLbl.Font = Enum.Font.GothamMedium
sbLbl.Text = "Speed Boost Value"
sbLbl.TextColor3 = Color3.fromRGB(230, 230, 245)
sbLbl.TextSize = 12
sbLbl.TextXAlignment = Enum.TextXAlignment.Left

local sbBox = Instance.new("TextBox")
sbBox.Parent = sbFrame
sbBox.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
sbBox.Position = UDim2.new(1, -65, 0.5, -12)
sbBox.Size = UDim2.new(0, 55, 0, 24)
sbBox.Font = Enum.Font.GothamBold
sbBox.Text = tostring(speedBoostValue)
sbBox.TextColor3 = Color3.fromRGB(255, 255, 255)
sbBox.TextSize = 12
local sbc2 = Instance.new("UICorner")
sbc2.CornerRadius = UDim.new(0, 4)
sbc2.Parent = sbBox

sbBox.FocusLost:Connect(function()
    local val = tonumber(sbBox.Text)
    if val then
        if val < 1 then val = 1 end
        if val > 2000 then val = 2000 end
        speedBoostValue = val
        sbBox.Text = tostring(val)
    else
        sbBox.Text = tostring(speedBoostValue)
    end
end)

RunService.RenderStepped:Connect(function()
    if speedBoostActive then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speedBoostValue
            end
        end
    end
end)

-- Instant Proximity / Grab Telur
local instantPromptActive = false
local promptConnections = {}

createToggle(mainTab, "Instant Proximity / Grab Telur", function(state)
    instantPromptActive = state
    if instantPromptActive then
        local function setupPrompt(prompt)
            if prompt:IsA("ProximityPrompt") then
                prompt.HoldDuration = 0
            end
        end
        for _, obj in ipairs(workspace:GetDescendants()) do
            setupPrompt(obj)
        end
        table.insert(promptConnections, workspace.DescendantAdded:Connect(setupPrompt))
    else
        for _, conn in ipairs(promptConnections) do
            conn:Disconnect()
        end
        promptConnections = {}
    end
end)


-- ==========================================
-- 2. WAYPOINT CUSTOM TAB
-- ==========================================
local waypointTab = TabContents["Waypoint"]

local wpInputFrame = Instance.new("Frame")
wpInputFrame.Parent = waypointTab
wpInputFrame.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
wpInputFrame.Size = UDim2.new(1, -10, 0, 42)
local wpiCorner = Instance.new("UICorner")
wpiCorner.CornerRadius = UDim.new(0, 6)
wpiCorner.Parent = wpInputFrame

local wpiLabel = Instance.new("Te