local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

-- Panel utama
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 430)
frame.Position = UDim2.new(0.5, -130, 0.5, -210)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.Parent = gui

-- Rounded corners untuk panel
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 16)
frameCorner.Parent = frame

-- UIListLayout untuk tombol-tombol
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = frame

-- Fungsi bikin tombol toggle futuristik
local function createToggle(name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    button.BorderColor3 = Color3.fromRGB(0, 255, 255)
    button.BorderSizePixel = 1
    button.TextColor3 = Color3.fromRGB(0, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 20 -- ukuran tulisan sama untuk semua toggle
    button.TextScaled = false
    button.Text = name .. ": ON"
    button.Parent = frame

    -- Rounded corners untuk tombol
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 12)
    uicorner.Parent = button

    local state = true
    button.MouseButton1Click:Connect(function()
        state = not state
        button.Text = name .. (state and ": ON" or ": OFF")
        callback(state)
    end)
end

-- Daftar fitur FPS Boost
createToggle("Shadows", function(state) Lighting.GlobalShadows = state end)
createToggle("Water", function(state) workspace:FindFirstChildOfClass("Terrain").WaterWaveSize = state and 0.1 or 0 end)
createToggle("Textures", function(state) 
    for _, d in pairs(workspace:GetDescendants()) do 
        if d:IsA("Decal") or d:IsA("Texture") then 
            d.Transparency = state and 0 or 1 
        end 
    end 
end)
createToggle("Particles", function(state) 
    for _, d in pairs(workspace:GetDescendants()) do 
        if d:IsA("ParticleEmitter") then 
            d.Enabled = state 
        end 
    end 
end)
createToggle("Render Distance", function(state) workspace.ExtentsSize = state and Vector3.new(500,500,500) or Vector3.new(100,100,100) end)
createToggle("PostEffects", function(state) 
    for _, d in pairs(Lighting:GetChildren()) do 
        if d:IsA("PostEffect") then 
            d.Enabled = state 
        end 
    end 
end)
createToggle("Lighting Mode", function(state) Lighting.EnvironmentDiffuseScale = state and 1 or 0 end)
createToggle("Materials", function(state) 
    for _, d in pairs(workspace:GetDescendants()) do 
        if d:IsA("BasePart") then 
            d.Material = state and Enum.Material.Plastic or Enum.Material.SmoothPlastic 
        end 
    end 
end)

-- Label nama di bawah panel
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 28)
title.Position = UDim2.new(0.5, 0, 1, -30)
title.AnchorPoint = Vector2.new(0.5, 0)
title.BackgroundTransparency = 1
title.Text = "FPS Boost Panel V1 - By Erland Hengker Baik🥴"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextSize = 11,5 -- supaya sama seperti toggle
title.TextScaled = false
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Rounded corners untuk label
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

-- Tambahkan padding ke frame supaya tombol tidak nempel
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 12)  -- jarak atas 12px
padding.PaddingBottom = UDim.new(0, 12)
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.Parent = frame
