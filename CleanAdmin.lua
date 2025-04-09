local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local UI = Instance.new("ScreenGui")
UI.Name = HttpService:GenerateGUID(false)
UI.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.65, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.1

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0.08, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local Title = Instance.new("TextLabel")
Title.Text = "Infinity Admin v2.0"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0.4, 0, 1, 0)

local CommandInput = Instance.new("TextBox")
CommandInput.Size = UDim2.new(0.6, -10, 1, -10)
CommandInput.Position = UDim2.new(0.4, 10, 0, 5)
CommandInput.PlaceholderText = " Enter command..."
CommandInput.TextColor3 = Color3.new(1, 1, 1)
CommandInput.Font = Enum.Font.Gotham
CommandInput.TextSize = 14
CommandInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1, 0, 0.07, 0)
Tabs.Position = UDim2.new(0, 0, 0.08, 0)
Tabs.BackgroundTransparency = 1

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(0.3, -5, 0.8, -10)
PlayerList.Position = UDim2.new(0, 5, 0.15, 5)
PlayerList.BackgroundTransparency = 1
PlayerList.ScrollBarThickness = 4

local OutputLog = Instance.new("ScrollingFrame")
OutputLog.Size = UDim2.new(0.65, -5, 0.8, -10)
OutputLog.Position = UDim2.new(0.35, 5, 0.15, 5)
OutputLog.BackgroundTransparency = 1
OutputLog.ScrollBarThickness = 4

local CommandList = {
    {
        Name = "kill",
        Aliases = {"k", "eliminate"},
        Description = "Kills target player",
        Function = function(args)
            -- Kill command implementation
        end
    },
    {
        Name = "teleport",
        Aliases = {"tp", "goto"},
        Description = "Teleport to player",
        Function = function(args)
            -- Teleport implementation
        end
    },
    {
        Name = "esp",
        Aliases = {"highlight"},
        Description = "Toggle player ESP",
        Function = function(args)
            -- ESP implementation
        end
    },
    {
        Name = "noclip",
        Aliases = {"nc"},
        Description = "Toggle noclip",
        Function = function(args)
            -- Noclip implementation
        end
    }
}

local ESPCache = {}
local NoclipActive = false
local NoclipConnection

local function CreatePlayerEntry(player)
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, -10, 0, 40)
    entry.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text = player.Name
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 14
    nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
    
    local espButton = Instance.new("TextButton")
    espButton.Text = "ESP"
    espButton.Size = UDim2.new(0.2, 0, 0.6, 0)
    espButton.Position = UDim2.new(0.6, 5, 0.2, 0)
    
    local tpButton = Instance.new("TextButton")
    tpButton.Text = "TP"
    tpButton.Size = UDim2.new(0.2, 0, 0.6, 0)
    tpButton.Position = UDim2.new(0.8, 5, 0.2, 0)
    
    return entry
end

local function UpdatePlayerList()
    PlayerList:ClearAllChildren()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local entry = CreatePlayerEntry(player)
            entry.Parent = PlayerList
        end
    end
end

local function ToggleESP(player)
    if not ESPCache[player] then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.Parent = player.Character
        ESPCache[player] = highlight
    else
        ESPCache[player]:Destroy()
        ESPCache[player] = nil
    end
end

local function ExecuteCommand(input)
    local args = {}
    for word in input:gmatch("%S+") do
        table.insert(args, word)
    end
    
    if #args == 0 then return end
    
    local command = string.lower(args[1])
    table.remove(args, 1)
    
    for _, cmd in ipairs(CommandList) do
        if command == cmd.Name or table.find(cmd.Aliases, command) then
            cmd.Function(args)
            return
        end
    end
end

CommandInput.FocusLost:Connect(function(enter)
    if enter then
        ExecuteCommand(CommandInput.Text)
        CommandInput.Text = ""
    end
end)

Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

UI.Parent = LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Parent = UI
TopBar.Parent = MainFrame
Title.Parent = TopBar
CommandInput.Parent = TopBar
Tabs.Parent = MainFrame
PlayerList.Parent = MainFrame
OutputLog.Parent = MainFrame

UpdatePlayerList()

local function Initialize()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {
        Position = UDim2.new(0.65, 0, 0.2, 0)
    }):Play()
end

Initialize()
