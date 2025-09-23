-- Script langsung eksekusi tanpa pengecekan key
local game = game
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Setup GUI sederhana
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 400, 0, 200)
Frame.Position = UDim2.new(0.5, -200, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 1
Frame.BorderColor3 = Color3.fromRGB(100, 100, 100)

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0.9, 0, 0.3, 0)
TextLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
TextLabel.Text = "JI SON YING - FREE VERSION"
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
TextLabel.TextScaled = true
TextLabel.TextWrapped = true
TextLabel.BackgroundTransparency = 1

TextButton.Parent = Frame
TextButton.Size = UDim2.new(0.6, 0, 0.3, 0)
TextButton.Position = UDim2.new(0.2, 0, 0.5, 0)
TextButton.Text = "LOAD SCRIPT"
TextButton.Font = Enum.Font.Gotham
TextButton.TextSize = 16
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
TextButton.BorderSizePixel = 1

-- Fungsi utama langsung load script
local function loadMainScript()
    TextLabel.Text = "⏳ Loading script..."
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
    
    -- Coba load script utama dari GitHub
    local success, result = pcall(function()
        return HttpService:GetAsync("https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/choose.txt")
    end)
    
    if success and result then
        local loadSuccess, errorMsg = pcall(function()
            loadstring(result)()
        end)
        
        if loadSuccess then
            TextLabel.Text = "✅ Script berhasil dimuat!"
            TextLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            -- Auto hide GUI setelah 3 detik
            wait(3)
            Frame.Visible = false
        else
            TextLabel.Text = "⚠️ Error eksekusi script: " .. tostring(errorMsg)
            TextLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    else
        TextLabel.Text = "⚠️ Gagal load dari server!"
        TextLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        -- Fallback: Coba source alternatif
        local fallbackScript = [[
            -- Basic script fallback
            print("JI SON YING Script Loaded")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            -- Contoh fungsi sederhana
            local function showMessage()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "JI SON YING",
                    Text = "Script aktif!",
                    Duration = 5
                })
            end
            
            showMessage()
        ]]
        
        local loadSuccess, errorMsg = pcall(function()
            loadstring(fallbackScript)()
        end)
        
        if loadSuccess then
            TextLabel.Text = "✅ Fallback script dijalankan!"
            wait(2)
            Frame.Visible = false
        end
    end
end

-- Event handler langsung eksekusi
TextButton.MouseButton1Click:Connect(function()
    loadMainScript()
end)

-- Hotkey untuk toggle GUI
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F9 then
        Frame.Visible = not Frame.Visible
    end
end)

-- Auto-execute setelah 2 detik (opsional)
wait(2)
TextLabel.Text = "Klik LOAD SCRIPT untuk mulai"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

print("JI SON YING GUI Ready - Free Version")
