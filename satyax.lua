local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local Clipboard = setclipboard or toclipboard or function() end

local ConfigFileName = "SATYA_EXPLOIT_Config.json"
local HttpService = game:GetService("HttpService")

local SavedData = {
    BaseCoord = "0, 0, 0",
    TreadmillCoord = "0, 0, 0",
    BackgroundId = "",
    Theme = "Default",
    SmartTP = false,
    AutoTreadmill = false,
    AutoHydra = false,
    AntiRagdoll = false,
    AntiStun = false
}

pcall(function()
    if readfile and isfile and isfile(ConfigFileName) then
        local decoded = HttpService:JSONDecode(readfile(ConfigFileName))
        if decoded then
            for k, v in pairs(decoded) do
                SavedData[k] = v
            end
        end
    end
end)

local function SaveConfig()
    pcall(function()
        if writefile then
            writefile(ConfigFileName, HttpService:JSONEncode(SavedData))
        end
    end)
end

local Themes = {
    Default = {Main = Color3.fromRGB(25, 30, 38), TopBar = Color3.fromRGB(18, 22, 28), Sidebar = Color3.fromRGB(20, 24, 30), Element = Color3.fromRGB(32, 38, 48), Accent = Color3.fromRGB(70, 130, 200), Text = Color3.fromRGB(200, 215, 235), Stroke = Color3.fromRGB(70, 90, 115)},
    Hitam = {Main = Color3.fromRGB(12, 12, 12), TopBar = Color3.fromRGB(5, 5, 5), Sidebar = Color3.fromRGB(8, 8, 8), Element = Color3.fromRGB(20, 20, 20), Accent = Color3.fromRGB(60, 60, 60), Text = Color3.fromRGB(230, 230, 230), Stroke = Color3.fromRGB(45, 45, 45)},
    Putih = {Main = Color3.fromRGB(240, 242, 245), TopBar = Color3.fromRGB(220, 224, 230), Sidebar = Color3.fromRGB(225, 230, 238), Element = Color3.fromRGB(255, 255, 255), Accent = Color3.fromRGB(90, 140, 220), Text = Color3.fromRGB(30, 35, 45), Stroke = Color3.fromRGB(180, 195, 210)},
    Kuning = {Main = Color3.fromRGB(35, 32, 22), TopBar = Color3.fromRGB(25, 22, 14), Sidebar = Color3.fromRGB(28, 25, 16), Element = Color3.fromRGB(48, 43, 28), Accent = Color3.fromRGB(230, 175, 40), Text = Color3.fromRGB(255, 235, 180), Stroke = Color3.fromRGB(110, 95, 50)},
    Biru = {Main = Color3.fromRGB(15, 25, 40), TopBar = Color3.fromRGB(10, 18, 30), Sidebar = Color3.fromRGB(12, 21, 35), Element = Color3.fromRGB(22, 36, 58), Accent = Color3.fromRGB(0, 160, 255), Text = Color3.fromRGB(190, 225, 255), Stroke = Color3.fromRGB(35, 85, 140)},
    Merah = {Main = Color3.fromRGB(35, 15, 15), TopBar = Color3.fromRGB(24, 10, 10), Sidebar = Color3.fromRGB(28, 12, 12), Element = Color3.fromRGB(50, 22, 22), Accent = Color3.fromRGB(230, 50, 50), Text = Color3.fromRGB(255, 200, 200), Stroke = Color3.fromRGB(120, 45, 45)},
    Hijau = {Main = Color3.fromRGB(15, 35, 20), TopBar = Color3.fromRGB(10, 24, 14), Sidebar = Color3.fromRGB(12, 28, 16), Element = Color3.fromRGB(22, 50, 30), Accent = Color3.fromRGB(40, 200, 90), Text = Color3.fromRGB(200, 255, 215), Stroke = Color3.fromRGB(45, 110, 60)},
    Ungu = {Main = Color3.fromRGB(28, 15, 38), TopBar = Color3.fromRGB(18, 10, 25), Sidebar = Color3.fromRGB(22, 12, 30), Element = Color3.fromRGB(42, 22, 58), Accent = Color3.fromRGB(160, 50, 230), Text = Color3.fromRGB(235, 200, 255), Stroke = Color3.fromRGB(90, 45, 120)},
    Pink = {Main = Color3.fromRGB(38, 15, 28), TopBar = Color3.fromRGB(25, 10, 18), Sidebar = Color3.fromRGB(30, 12, 22), Element = Color3.fromRGB(58, 22, 42), Accent = Color3.fromRGB(240, 80, 160), Text = Color3.fromRGB(255, 210, 235), Stroke = Color3.fromRGB(120, 45, 85)},
    Cyan = {Main = Color3.fromRGB(12, 32, 38), TopBar = Color3.fromRGB(8, 22, 26), Sidebar = Color3.fromRGB(10, 26, 30), Element = Color3.fromRGB(18, 48, 58), Accent = Color3.fromRGB(0, 210, 240), Text = Color3.fromRGB(190, 245, 255), Stroke = Color3.fromRGB(35, 100, 120)},
    Orange = {Main = Color3.fromRGB(38, 24, 12), TopBar = Color3.fromRGB(26, 16, 8), Sidebar = Color3.fromRGB(30, 19, 10), Element = Color3.fromRGB(58, 38, 18), Accent = Color3.fromRGB(255, 120, 0), Text = Color3.fromRGB(255, 220, 190), Stroke = Color3.fromRGB(120, 75, 35)},
    Lime = {Main = Color3.fromRGB(22, 38, 12), TopBar = Color3.fromRGB(14, 25, 8), Sidebar = Color3.fromRGB(17, 30, 10), Element = Color3.fromRGB(34, 58, 18), Accent = Color3.fromRGB(140, 255, 0), Text = Color3.fromRGB(235, 255, 190), Stroke = Color3.fromRGB(75, 120, 35)},
    Magenta = {Main = Color3.fromRGB(38, 12, 35), TopBar = Color3.fromRGB(25, 8, 23), Sidebar = Color3.fromRGB(30, 10, 28), Element = Color3.fromRGB(58, 18, 54), Accent = Color3.fromRGB(255, 0, 180), Text = Color3.fromRGB(255, 200, 245), Stroke = Color3.fromRGB(120, 35, 110)},
    Teal = {Main = Color3.fromRGB(12, 35, 30), TopBar = Color3.fromRGB(8, 23, 20), Sidebar = Color3.fromRGB(10, 28, 24), Element = Color3.fromRGB(18, 52, 45), Accent = Color3.fromRGB(0, 200, 150), Text = Color3.fromRGB(190, 255, 235), Stroke = Color3.fromRGB(35, 110, 95)},
    Gold = {Main = Color3.fromRGB(38, 32, 12), TopBar = Color3.fromRGB(25, 21, 8), Sidebar = Color3.fromRGB(30, 25, 10), Element = Color3.fromRGB(58, 48, 18), Accent = Color3.fromRGB(255, 200, 0), Text = Color3.fromRGB(255, 240, 190), Stroke = Color3.fromRGB(120, 100, 35)},
    Navy = {Main = Color3.fromRGB(10, 15, 30), TopBar = Color3.fromRGB(6, 10, 20), Sidebar = Color3.fromRGB(8, 12, 25), Element = Color3.fromRGB(16, 24, 48), Accent = Color3.fromRGB(50, 100, 255), Text = Color3.fromRGB(190, 210, 255), Stroke = Color3.fromRGB(30, 50, 110)},
    Crimson = {Main = Color3.fromRGB(35, 10, 18), TopBar = Color3.fromRGB(23, 6, 12), Sidebar = Color3.fromRGB(28, 8, 15), Element = Color3.fromRGB(54, 16, 28), Accent = Color3.fromRGB(220, 20, 60), Text = Color3.fromRGB(255, 200, 210), Stroke = Color3.fromRGB(110, 35, 55)},
    Emerald = {Main = Color3.fromRGB(10, 35, 22), TopBar = Color3.fromRGB(6, 23, 14), Sidebar = Color3.fromRGB(8, 28, 17), Element = Color3.fromRGB(16, 54, 34), Accent = Color3.fromRGB(0, 230, 110), Text = Color3.fromRGB(190, 255, 220), Stroke = Color3.fromRGB(30, 110, 70)},
    Violet = {Main = Color3.fromRGB(25, 12, 38), TopBar = Color3.fromRGB(16, 8, 25), Sidebar = Color3.fromRGB(20, 10, 30), Element = Color3.fromRGB(38, 18, 58), Accent = Color3.fromRGB(140, 40, 255), Text = Color3.fromRGB(225, 190, 255), Stroke = Color3.fromRGB(80, 35, 120)},
    Bronze = {Main = Color3.fromRGB(35, 25, 15), TopBar = Color3.fromRGB(23, 16, 10), Sidebar = Color3.fromRGB(28, 20, 12), Element = Color3.fromRGB(54, 38, 23), Accent = Color3.fromRGB(205, 127, 50), Text = Color3.fromRGB(255, 230, 200), Stroke = Color3.fromRGB(110, 80, 45)},
    Silver = {Main = Color3.fromRGB(32, 35, 38), TopBar = Color3.fromRGB(21, 23, 25), Sidebar = Color3.fromRGB(26, 28, 30), Element = Color3.fromRGB(48, 52, 56), Accent = Color3.fromRGB(192, 192, 192), Text = Color3.fromRGB(240, 245, 250), Stroke = Color3.fromRGB(95, 105, 115)},
    Coffee = {Main = Color3.fromRGB(30, 20, 15), TopBar = Color3.fromRGB(20, 13, 10), Sidebar = Color3.fromRGB(25, 16, 12), Element = Color3.fromRGB(45, 30, 22), Accent = Color3.fromRGB(180, 110, 70), Text = Color3.fromRGB(255, 225, 210), Stroke = Color3.fromRGB(95, 65, 45)},
    Midnight = {Main = Color3.fromRGB(8, 10, 15), TopBar = Color3.fromRGB(4, 6, 10), Sidebar = Color3.fromRGB(6, 8, 12), Element = Color3.fromRGB(14, 18, 26), Accent = Color3.fromRGB(70, 130, 255), Text = Color3.fromRGB(180, 200, 240), Stroke = Color3.fromRGB(25, 35, 60)},
    Ruby = {Main = Color3.fromRGB(40, 10, 15), TopBar = Color3.fromRGB(26, 6, 10), Sidebar = Color3.fromRGB(32, 8, 12), Element = Color3.fromRGB(60, 16, 24), Accent = Color3.fromRGB(255, 36, 0), Text = Color3.fromRGB(255, 200, 190), Stroke = Color3.fromRGB(120, 35, 45)},
    Sapphire = {Main = Color3.fromRGB(10, 20, 40), TopBar = Color3.fromRGB(6, 13, 26), Sidebar = Color3.fromRGB(8, 16, 32), Element = Color3.fromRGB(16, 32, 62), Accent = Color3.fromRGB(15, 82, 186), Text = Color3.fromRGB(190, 220, 255), Stroke = Color3.fromRGB(35, 70, 130)},
    Amber = {Main = Color3.fromRGB(40, 26, 10), TopBar = Color3.fromRGB(26, 17, 6), Sidebar = Color3.fromRGB(32, 21, 8), Element = Color3.fromRGB(62, 40, 16), Accent = Color3.fromRGB(255, 191, 0), Text = Color3.fromRGB(255, 235, 190), Stroke = Color3.fromRGB(130, 85, 30)},
    Turquoise = {Main = Color3.fromRGB(10, 35, 35), TopBar = Color3.fromRGB(6, 23, 23), Sidebar = Color3.fromRGB(8, 28, 28), Element = Color3.fromRGB(16, 54, 54), Accent = Color3.fromRGB(64, 224, 208), Text = Color3.fromRGB(190, 255, 250), Stroke = Color3.fromRGB(35, 110, 110)},
    Lavender = {Main = Color3.fromRGB(28, 22, 38), TopBar = Color3.fromRGB(18, 14, 25), Sidebar = Color3.fromRGB(22, 17, 30), Element = Color3.fromRGB(44, 34, 58), Accent = Color3.fromRGB(180, 140, 255), Text = Color3.fromRGB(240, 230, 255), Stroke = Color3.fromRGB(90, 70, 120)},
    Coral = {Main = Color3.fromRGB(38, 20, 18), TopBar = Color3.fromRGB(25, 13, 12), Sidebar = Color3.fromRGB(30, 16, 14), Element = Color3.fromRGB(58, 31, 28), Accent = Color3.fromRGB(255, 111, 97), Text = Color3.fromRGB(255, 220, 215), Stroke = Color3.fromRGB(120, 65, 60)},
    Mint = {Main = Color3.fromRGB(15, 35, 28), TopBar = Color3.fromRGB(10, 23, 18), Sidebar = Color3.fromRGB(12, 28, 22), Element = Color3.fromRGB(24, 54, 43), Accent = Color3.fromRGB(152, 255, 152), Text = Color3.fromRGB(210, 255, 225), Stroke = Color3.fromRGB(50, 110, 90)},
    Plum = {Main = Color3.fromRGB(32, 12, 28), TopBar = Color3.fromRGB(21, 8, 18), Sidebar = Color3.fromRGB(26, 10, 22), Element = Color3.fromRGB(48, 19, 42), Accent = Color3.fromRGB(142, 69, 133), Text = Color3.fromRGB(255, 210, 245), Stroke = Color3.fromRGB(100, 40, 90)},
    Charcoal = {Main = Color3.fromRGB(22, 22, 22), TopBar = Color3.fromRGB(14, 14, 14), Sidebar = Color3.fromRGB(18, 18, 18), Element = Color3.fromRGB(34, 34, 34), Accent = Color3.fromRGB(100, 100, 100), Text = Color3.fromRGB(220, 220, 220), Stroke = Color3.fromRGB(70, 70, 70)}
}

local activeThemeElements = {}

local function RegisterThemeElement(element, elementType)
    table.insert(activeThemeElements, {Instance = element, Type = elementType})
    local t = Themes[SavedData.Theme] or Themes.Default
    if elementType == "Main" then element.BackgroundColor3 = t.Main
    elseif elementType == "TopBar" then element.BackgroundColor3 = t.TopBar
    elseif elementType == "Sidebar" then element.BackgroundColor3 = t.Sidebar
    elseif elementType == "Element" then element.BackgroundColor3 = t.Element
    elseif elementType == "Accent" then element.BackgroundColor3 = t.Accent
    elseif elementType == "Text" then element.TextColor3 = t.Text
    elseif elementType == "Stroke" then element.Color = t.Stroke end
end

local function ApplyTheme(themeName)
    if not Themes[themeName] then themeName = "Default" end
    SavedData.Theme = themeName
    SaveConfig()
    
    local t = Themes[themeName]
    for _, item in ipairs(activeThemeElements) do
        if item.Instance and item.Instance.Parent then
            if item.Type == "Main" then item.Instance.BackgroundColor3 = t.Main
            elseif item.Type == "TopBar" then item.Instance.BackgroundColor3 = t.TopBar
            elseif item.Type == "Sidebar" then item.Instance.BackgroundColor3 = t.Sidebar
            elseif item.Type == "Element" then item.Instance.BackgroundColor3 = t.Element
            elseif item.Type == "Accent" then item.Instance.BackgroundColor3 = t.Accent
            elseif item.Type == "Text" then item.Instance.TextColor3 = t.Text
            elseif item.Type == "Stroke" then item.Instance.Color = t.Stroke end
        end
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SATYA_EXPLOIT"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
RegisterThemeElement(MainFrame, "Main")
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame
MainFrame.BackgroundTransparency = 0.05

local BgImage = Instance.new("ImageLabel")
BgImage.Name = "CustomBackground"
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.ScaleType = Enum.ScaleType.Slice
BgImage.ZIndex = 0
BgImage.Parent = MainFrame

local BgCorner = Instance.new("UICorner")
BgCorner.CornerRadius = UDim.new(0, 8)
BgCorner.Parent = BgImage

if SavedData.BackgroundId ~= "" then
    local numId = string.match(SavedData.BackgroundId, "%d+")
    if numId then BgImage.Image = "rbxassetid://" .. numId else BgImage.Image = SavedData.BackgroundId end
end

local MainStroke = Instance.new("UIStroke")
RegisterThemeElement(MainStroke, "Stroke")
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 32)
RegisterThemeElement(TopBar, "TopBar")
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 2
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.75, 0, 1, 0)
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.ZIndex = 2
Title.Text = "SATYA⚡⚡EXPLOIT"
RegisterThemeElement(Title, "Text")
Title.TextSize = 15
Title.Font = Enum.Font.FredokaOne
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = Color3.fromRGB(0, 0, 0)
TitleStroke.Thickness = 1.8
TitleStroke.Parent = Title

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -13)
RegisterThemeElement(CloseBtn, "Element")
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 2
CloseBtn.Text = "✕"
RegisterThemeElement(CloseBtn, "Text")
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -60, 0.5, -13)
RegisterThemeElement(MinBtn, "Element")
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 2
MinBtn.Text = "一"
RegisterThemeElement(MinBtn, "Text")
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 11
MinBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinBtn

local ResizeGrip = Instance.new("TextButton")
ResizeGrip.Size = UDim2.new(0, 16, 0, 16)
ResizeGrip.Position = UDim2.new(1, -16, 1, -16)
ResizeGrip.BackgroundTransparency = 1
ResizeGrip.ZIndex = 2
ResizeGrip.Text = "◢"
RegisterThemeElement(ResizeGrip, "Text")
ResizeGrip.TextSize = 12
ResizeGrip.Parent = MainFrame

local resizing = false
local resizeStartPos, frameStartSize

ResizeGrip.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStartPos = input.Position
        frameStartSize = MainFrame.AbsoluteSize
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStartPos
        local newWidth = math.clamp(frameStartSize.X + delta.X, 300, 800)
        local newHeight = math.clamp(frameStartSize.Y + delta.Y, 220, 600)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

local FloatingLogo = Instance.new("TextButton")
FloatingLogo.Size = UDim2.new(0, 65, 0, 55)
FloatingLogo.Position = UDim2.new(0, 30, 0, 30)
FloatingLogo.BackgroundTransparency = 1
FloatingLogo.Text = "SX"
FloatingLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingLogo.TextSize = 36
FloatingLogo.Font = Enum.Font.Code
FloatingLogo.Visible = false
FloatingLogo.Active = true
FloatingLogo.Draggable = true
FloatingLogo.Parent = ScreenGui

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(0, 0, 0)
FloatStroke.Thickness = 3
FloatStroke.Parent = FloatingLogo

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatingLogo.Visible = true
end)

FloatingLogo.MouseButton1Click:Connect(function()
    FloatingLogo.Visible = false
    MainFrame.Visible = true
end)

local ContainerHolder = Instance.new("Frame")
ContainerHolder.Size = UDim2.new(1, -115, 1, -36)
ContainerHolder.Position = UDim2.new(0, 115, 0, 34)
ContainerHolder.BackgroundTransparency = 1
ContainerHolder.ZIndex = 2
ContainerHolder.Parent = MainFrame

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 110, 1, -34)
Sidebar.Position = UDim2.new(0, 0, 0, 34)
RegisterThemeElement(Sidebar, "Sidebar")
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 1
Sidebar.ZIndex = 2
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.Padding = UDim.new(0, 4)

local pages = {}
local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.Visible = false
    page.ScrollBarThickness = 2
    page.CanvasSize = UDim2.new(0, 0, 0, 600)
    page.ZIndex = 2
    page.Parent = ContainerHolder
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.Padding = UDim.new(0, 4)
    
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -4, 0, 30)
    RegisterThemeElement(tabBtn, "Element")
    tabBtn.BorderSizePixel = 0
    tabBtn.ZIndex = 2
    tabBtn.Text = name
    RegisterThemeElement(tabBtn, "Text")
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 11
    tabBtn.Parent = Sidebar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 5)
    tabCorner.Parent = tabBtn
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
    
    if #pages == 0 then page.Visible = true end
    table.insert(pages, page)
    return page
end

local PagePlayer = CreatePage("Player")
local PageWaypoint = CreatePage("Waypoint")
local PageEgg = CreatePage("Be an Egg")
local PageMisc = CreatePage("Misc")
local PageTroll = CreatePage("Troll")
local PagePersonal = CreatePage("Personalize")

local function AddToggle(page, text, state, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 32)
    RegisterThemeElement(f, "Element")
    f.BorderSizePixel = 0
    f.ZIndex = 2
    f.Parent = page
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = f
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.65, 0, 1, 0)
    l.Position = UDim2.new(0.04, 0, 0, 0)
    l.BackgroundTransparency = 1
    l.ZIndex = 2
    l.Text = text
    RegisterThemeElement(l, "Text")
    l.Font = Enum.Font.Gotham
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 36, 0, 18)
    b.Position = UDim2.new(1, -42, 0.5, -9)
    b.Text = 