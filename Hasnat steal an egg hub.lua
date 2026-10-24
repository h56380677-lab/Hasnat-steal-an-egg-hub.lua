-- ========================================================
-- HASNAT HUB - STEAL AN EGG SCRIPT
-- ========================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- CONFIGURATION
local HUB_NAME = "HASNAT HUB"
-- REPLACE THIS WITH YOUR UPLOADED LOGO ID
local LOGO_ID = "https://cdn.phototourl.com/member/2026-10-24-52453695-f35c-4b7e-b688-69cbdc8578a8.png" 

-- DESTROY OLD GUI
local oldGui = CoreGui:FindFirstChild("HasnatHubUI")
if oldGui then oldGui:Destroy() end

-- CREATE GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HasnatHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- NEON BORDER (Matches image theme)
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 170, 0) -- Orange/Yellow
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BorderSizePixel = 0

-- TITLE
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 50, 0, 0)
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = HUB_NAME
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- LOGO IMAGE
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Parent = TopBar
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0, 8, 0, 7)
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Image = LOGO_ID

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = TopBar
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.Size = UDim2.new(0, 40, 0, 45)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 65, 65)
CloseBtn.TextSize = 18

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- MINIMIZE BUTTON
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Parent = TopBar
MinBtn.BackgroundTransparency = 1
MinBtn.Position = UDim2.new(1, -80, 0, 0)
MinBtn.Size = UDim2.new(0, 40, 0, 45)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 24

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 300, 0, 45) or UDim2.new(0, 300, 0, 400)
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = targetSize}):Play()
end)

-- SCROLLING FRAME
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0, 10, 0, 55)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -65)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 170, 0)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- NOTIFICATION SYSTEM
local function Notify(text)
    local NotifyGui = Instance.new("TextLabel")
    NotifyGui.Parent = ScreenGui
    NotifyGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    NotifyGui.Position = UDim2.new(0, 10, 1, -60)
    NotifyGui.Size = UDim2.new(0, 250, 0, 40)
    NotifyGui.Font = Enum.Font.GothamSemibold
    NotifyGui.Text = "  " .. text
    NotifyGui.TextColor3 = Color3.fromRGB(255, 170, 0)
    NotifyGui.TextSize = 12
    NotifyGui.TextXAlignment = Enum.TextXAlignment.Left
    NotifyGui.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = NotifyGui
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255, 170, 0)
    Stroke.Thickness = 1
    Stroke.Parent = NotifyGui
    
    task.delay(2.5, function()
        TweenService:Create(NotifyGui, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        task.wait(0.5)
        NotifyGui:Destroy()
    end)
end

-- CREATE BUTTON FUNCTION
local function CreateButton(text, callback, isToggle)
    local Button = Instance.new("TextButton")
    Button.Name = text:gsub("%s+", "")
    Button.Parent = ScrollingFrame
    Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Button.Size = UDim2.new(1, 0, 0, 38)
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = "  " .. text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.AutoButtonColor = false
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Button
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(50, 50, 50)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Button
    
    local isToggled = false
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        BtnStroke.Color = Color3.fromRGB(255, 170, 0)
    end)
    Button.MouseLeave:Connect(function()
        if not isToggled then
            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            BtnStroke.Color = Color3.fromRGB(50, 50, 50)
        end
    end)
    
    Button.MouseButton1Click:Connect(function()
        if isToggle then
            isToggled = not isToggled
            if isToggled then
                Button.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
                Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                BtnStroke.Color = Color3.fromRGB(255, 170, 0)
            else
                Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                BtnStroke.Color = Color3.fromRGB(50, 50, 50)
            end
            callback(isToggled)
        else
            TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 170, 0), TextColor3 = Color3.fromRGB(0,0,0)}):Play()
            task.wait(0.15)
            TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(25, 25, 25), TextColor3 = Color3.fromRGB(255,255,255)}):Play()
            callback()
        end
    end)
    
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)
end

-- ========================================================
-- FEATURES
-- ========================================================

-- 1. AUTO STEAL EGG (Toggle)
local autoStealConnection = nil

CreateButton("Auto Steal Egg", function(state)
    if state then
        Notify("Auto Steal: ON")
        
        -- We use a loop that constantly checks for eggs near the player
        autoStealConnection = RunService.Heartbeat:Connect(function()
            local character = player.Character
            if not character then return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local backpack = player:FindFirstChild("Backpack")
            
            if hrp then
                -- SCAN WORKSPACE FOR EGGS
                for _, obj in pairs(workspace:GetDescendants()) do
                    -- Most steal games use these names
                    if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or obj.Name:lower():find("spawn")) then
                        -- If the egg is close to the player (within 20 studs)
                        if (hrp.Position - obj.Position).Magnitude < 20 then
                            -- Try to trigger touch events / prompts
                            local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                            if prompt then
                                fireproximityprompt(prompt)
                            end
                            
                            -- Also try firing the egg's Touch event manually
                            if obj:FindFirstChild("TouchInterest") then
                                firetouchinterest(hrp, obj, 0)
                                task.wait(0.05)
                                firetouchinterest(hrp, obj, 1)
                            end
                            
                            -- Attempt to equip tool if it's in backpack
                            if backpack then
                                for _, tool in pairs(backpack:GetChildren()) do
                                    if tool:IsA("Tool") and tool.Name:lower():find("egg") then
                                        tool.Parent = character
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        Notify("Auto Steal: OFF")
        if autoStealConnection then
            autoStealConnection:Disconnect()
            autoStealConnection = nil
        end
    end
end, true)

-- 2. TELEPORT TO EGGS
CreateButton("Teleport to All Eggs", function()
    local character = player.Character
    if not character then return Notify("Character not found!") end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    Notify("Teleporting...")
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or obj.Name:lower():find("spawn")) then
            hrp.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
            task.wait(0.1)
        end
    end
    Notify("Teleport Complete!")
end)

-- 3. FAST WALK SPEED
CreateButton("WalkSpeed 150", function()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = 150
        Notify("WalkSpeed set to 150")
    end
end)

-- 4. RESET WALK SPEED
CreateButton("Reset WalkSpeed", function()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = 16
        Notify("WalkSpeed Reset")
    end
end)

-- 5. INFINITE JUMP
CreateButton("Infinite Jump", function(state)
    -- Note: This toggle assumes you have a loop running. 
    -- Here is a simple way using UserInputService
    if state then
        Notify("Infinite Jump: ON")
        local infJumpConn
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:ChangeState("Jumping")
            end
        end)
        -- Store connection to disconnect later
        _G.HasnatInfJump = infJumpConn
    else
        Notify("Infinite Jump: OFF")
        if _G.HasnatInfJump then
            _G.HasnatInfJump:Disconnect()
            _G.HasnatInfJump = nil
        end
    end
end, true)

-- 6. ANTI-RAGDOLL / GOD MODE
CreateButton("God Mode (Health)", function()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.MaxHealth = math.huge
        character.Humanoid.Health = math.huge
        Notify("God Mode Activated")
    end
end)

-- 7. REJOIN SERVER
CreateButton("Rejoin Server", function()
    Notify("Rejoining...")
    task.wait(1)
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)

-- LOAD NOTIFICATION
Notify("HASNAT HUB Loaded Successfully!")
