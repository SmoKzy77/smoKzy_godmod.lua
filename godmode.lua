--[[
    MENU GOD MODE - By SmoKzy
    Loadstring Version
]]

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GodModeMenu_SmoKzy"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Botão Flutuante (Toggle)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 20, 0, 200)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = "⚡"
ToggleBtn.TextSize = 30
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = ScreenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 12)
toggleCorner.Parent = ToggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.fromRGB(255, 0, 0)
toggleStroke.Parent = ToggleBtn

-- Painel Principal
local Panel = Instance.new("Frame")
Panel.Name = "MainPanel"
Panel.Size = UDim2.new(0, 280, 0, 380)
Panel.Position = UDim2.new(0, 90, 0, 200)
Panel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Panel.BorderSizePixel = 0
Panel.Visible = false
Panel.Parent = ScreenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 14)
panelCorner.Parent = Panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Thickness = 2.5
panelStroke.Color = Color3.fromRGB(255, 0, 0)
panelStroke.Parent = Panel

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "⚡ GOD MODE ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = Panel

-- Subtítulo
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 45)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "By SmoKzy"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = Panel

-- Container de Botões
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(1, -20, 1, -90)
ButtonHolder.Position = UDim2.new(0, 10, 0, 75)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = Panel

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = ButtonHolder

-- Função para criar botões
local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamMedium
    btn.BorderSizePixel = 0
    btn.Parent = ButtonHolder

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Parent = btn

    btn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        }):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        if callback then callback(btn) end
    end)

    return btn
end

-- ============================================
-- FUNÇÕES GOD MODE
-- ============================================

local player = game.Players.LocalPlayer
local godModeAtivo = false
local speedAtivo = false
local jumpAtivo = false
local flyAtivo = false
local infiniteJumpConnection

-- GOD MODE
createButton("🛡️ God Mode", function(btn)
    godModeAtivo = not godModeAtivo
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.MaxHealth = godModeAtivo and math.huge or 100
        humanoid.Health = godModeAtivo and math.huge or 100
    end
    btn.Text = godModeAtivo and "🛡️ God Mode: ON" or "🛡️ God Mode"
end)

-- SPEED
createButton("💨 Speed Boost", function(btn)
    speedAtivo = not speedAtivo
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedAtivo and 100 or 16
    end
    btn.Text = speedAtivo and "💨 Speed: ON" or "💨 Speed Boost"
end)

-- JUMP POWER
createButton("🦘 Super Jump", function(btn)
    jumpAtivo = not jumpAtivo
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = jumpAtivo and 200 or 50
        humanoid.UseJumpPower = true
    end
    btn.Text = jumpAtivo and "🦘 Jump: ON" or "🦘 Super Jump"
end)

-- INFINITE JUMP
createButton("♾️ Infinite Jump", function(btn)
    if infiniteJumpConnection then
        infiniteJumpConnection:Disconnect()
        infiniteJumpConnection = nil
        btn.Text = "♾️ Infinite Jump"
    else
        infiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            local char = player.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
        btn.Text = "♾️ Infinite Jump: ON"
    end
end)

-- FLY
createButton("🕊️ Fly", function(btn)
    flyAtivo = not flyAtivo
    local char = player.Character
    if not char then return end

    if flyAtivo then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end

        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp

        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 1000
        bg.Parent = hrp

        _G.FlyBV = bv
        _G.FlyBG = bg

        task.spawn(function()
            while flyAtivo and char.Parent do
                local camera = workspace.CurrentCamera
                local move = Vector3.zero
                local UIS = game:GetService("UserInputService")

                if UIS:IsKeyDown(Enum.KeyCode.W) then move += camera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then move -= camera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then move -= camera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then move += camera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end

                if move.Magnitude > 0 then
                    bv.Velocity = move.Unit * 60
                else
                    bv.Velocity = Vector3.zero
                end
                bg.CFrame = camera.CFrame
                task.wait()
            end
        end)

        btn.Text = "🕊️ Fly: ON (WASD + Space)"
    else
        if _G.FlyBV then _G.FlyBV:Destroy() _G.FlyBV = nil end
        if _G.FlyBG then _G.FlyBG:Destroy() _G.FlyBG = nil end
        btn.Text = "🕊️ Fly"
    end
end)

-- RESETAR
createButton("🔄 Reset Character", function()
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Health = 0 end
    end
end)

-- ============================================
-- RGB ANIMATION
-- ============================================

local hue = 0
task.spawn(function()
    while ScreenGui.Parent do
        hue = (hue + 0.005) % 1
        local color = Color3.fromHSV(hue, 1, 1)

        panelStroke.Color = color
        toggleStroke.Color = color
        Title.TextColor3 = color
        toggleStroke.Thickness = 2 + math.sin(tick() * 3) * 0.5

        task.wait(0.03)
    end
end)

-- ============================================
-- TOGGLE PANEL + DRAG
-- ============================================

ToggleBtn.MouseButton1Click:Connect(function()
    Panel.Visible = not Panel.Visible
end)

local dragging, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Panel.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Panel.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("✅ Menu God Mode By SmoKzy carregado!")
