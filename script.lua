-- Tạo ScreenGui cho menu
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 500)
frame.Position = UDim2.new(0.5, -150, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Text = "NGO SANG ROBLOX"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = frame

-- Biến lưu trạng thái bật/tắt chức năng
local autoFarmActive = false
local autoQuestActive = false
local teleportActive = false
local godModeActive = false
local speedActive = false
local flyActive = false
local antiAFKActive = false

-- Tạo hàm tạo nút cho GUI
local function createButton(text, position, onClick)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = position
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    button.Parent = frame

    button.MouseButton1Click:Connect(onClick)
end

-- 1. Auto Farm (Cày level tự động)
local function autoFarm()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid")
    
    while autoFarmActive and humanoid.Health > 0 do
        local target = nil
        local closestDistance = math.huge
        for _, enemy in pairs(workspace:GetChildren()) do
            if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                local distance = (enemy.PrimaryPart.Position - character.PrimaryPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    target = enemy
                end
            end
        end
        
        if target then
            character:SetPrimaryPartCFrame(target.PrimaryPart.CFrame)
            wait(1)
        else
            print("Không tìm thấy kẻ địch!")
        end
        wait(1)
    end
end

-- 2. Auto Quest (Hoàn thành nhiệm vụ tự động)
local function autoQuest()
    local player = game.Players.LocalPlayer
    local questNpc = workspace:FindFirstChild("QuestNPC")
    
    if autoQuestActive and questNpc then
        player.Character:MoveTo(questNpc.Position)
        wait(2)
        print("Đã hoàn thành nhiệm vụ!")
    else
        print("Không tìm thấy NPC nhiệm vụ!")
    end
end

-- 3. Teleport (Di chuyển đến vị trí khác)
local function teleportToLocation()
    local player = game.Players.LocalPlayer
    local teleportPosition = workspace:FindFirstChild("TeleportLocation")
    
    if teleportActive and teleportPosition then
        player.Character:SetPrimaryPartCFrame(teleportPosition.CFrame)
        print("Đã di chuyển đến vị trí mới!")
    else
        print("Không tìm thấy vị trí teleport!")
    end
end

-- 4. God Mode (Chế độ bất tử)
local function godMode()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid")
    
    if godModeActive then
        humanoid.Health = math.huge
        humanoid.HealthChanged:Connect(function()
            humanoid.Health = math.huge
        end)
        print("Chế độ God Mode đã kích hoạt!")
    end
end

-- 5. Speed (Tăng tốc độ di chuyển)
local function increaseSpeed()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid")
    
    if speedActive then
        humanoid.WalkSpeed = 100  -- Tăng tốc độ di chuyển
        print("Tốc độ đã được tăng lên!")
    end
end

-- 6. Fly (Bay)
local function fly()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid")
    
    if flyActive then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyVelocity.Parent = character.PrimaryPart
        
        while flyActive do
            wait(0.1)
            bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        end
    end
end

-- 7. Anti-AFK (Chống bị AFK Kick)
local function antiAFK()
    local player = game.Players.LocalPlayer
    while antiAFKActive do
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, 0.1)
            end
        end
        wait(60)
    end
end

-- Các hàm bật/tắt các chức năng
createButton("Toggle Auto Farm", UDim2.new(0, 0, 0, 60), function()
    autoFarmActive = not autoFarmActive
    if autoFarmActive then
        autoFarm()
    end
end)

createButton("Toggle Auto Quest", UDim2.new(0, 0, 0, 120), function()
    autoQuestActive = not autoQuestActive
    if autoQuestActive then
        autoQuest()
    end
end)

createButton("Toggle Teleport", UDim2.new(0, 0, 0, 180), function()
    teleportActive = not teleportActive
    if teleportActive then
        teleportToLocation()
    end
end)

createButton("Toggle God Mode", UDim2.new(0, 0, 0, 240), function()
    godModeActive = not godModeActive
    if godModeActive then
        godMode()
    end
end)

createButton("Toggle Speed", UDim2.new(0, 0, 0, 300), function()
    speedActive = not speedActive
    if speedActive then
        increaseSpeed()
    end
end)

createButton("Toggle Fly", UDim2.new(0, 0, 0, 360), function()
    flyActive = not flyActive
    if flyActive then
        fly()
    end
end)

createButton("Toggle Anti-AFK", UDim2.new(0, 0, 0, 420), function()
    antiAFKActive = not antiAFKActive
    if antiAFKActive then
        antiAFK()
    end
end)
