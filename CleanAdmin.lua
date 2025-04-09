local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local UI = Instance.new("ScreenGui")
UI.Name = "CleanAdmin"
UI.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.25, 0, 0.4, 0)
MainFrame.Position = UDim2.new(0.72, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
MainFrame.Parent = UI

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local CommandInput = Instance.new("TextBox")
CommandInput.Size = UDim2.new(1, -20, 0.1, 0)
CommandInput.Position = UDim2.new(0, 10, 0.9, -10)
CommandInput.PlaceholderText = " Enter command..."
CommandInput.Parent = MainFrame

UI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ESPCache = {}
local NoclipActive = false

local function ToggleESP(target)
    if target and target.Character then
        if ESPCache[target] then
            ESPCache[target]:Destroy()
            ESPCache[target] = nil
        else
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.new(1, 0.2, 0.2)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.Parent = target.Character
            ESPCache[target] = highlight
        end
    end
end

local function ToggleNoclip()
    NoclipActive = not NoclipActive
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not NoclipActive
            end
        end
    end
end

CommandInput.FocusLost:Connect(function(enter)
    if enter then
        local args = string.split(CommandInput.Text, " ")
        local command = string.lower(args[1])
        
        if command == "esp" then
            local target = Players:FindFirstChild(args[2])
            ToggleESP(target)
        elseif command == "noclip" then
            ToggleNoclip()
        end
        
        CommandInput.Text = ""
    end
end)