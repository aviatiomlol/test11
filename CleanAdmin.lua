local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local UI = Instance.new("ScreenGui")
UI.Name = "ModernAdmin"
UI.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.3, 0, 0.45, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
MainFrame.BackgroundTransparency = 0.15

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0.15, 0)
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local Title = Instance.new("TextLabel")
Title.Text = "ADMIN PANEL"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 1, 0)

local CommandInput = Instance.new("TextBox")
CommandInput.Size = UDim2.new(1, -40, 0.1, 0)
CommandInput.Position = UDim2.new(0, 20, 0.85, -15)
CommandInput.PlaceholderText = " Enter command..."
CommandInput.TextColor3 = Color3.new(1, 1, 1)
CommandInput.Font = Enum.Font.Gotham
CommandInput.TextSize = 14
CommandInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CommandInput.ClearTextOnFocus = false

local OutputLog = Instance.new("ScrollingFrame")
OutputLog.Size = UDim2.new(1, -40, 0.65, -20)
OutputLog.Position = UDim2.new(0, 20, 0.2, 0)
OutputLog.BackgroundTransparency = 1
OutputLog.ScrollBarThickness = 4
OutputLog.CanvasSize = UDim2.new(0, 0, 2, 0)

local LogLayout = Instance.new("UIListLayout")
LogLayout.Padding = UDim.new(0, 8)

UI.Parent = LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Parent = UI
Header.Parent = MainFrame
Title.Parent = Header
CommandInput.Parent = MainFrame
OutputLog.Parent = MainFrame
LogLayout.Parent = OutputLog

local DropShadow = Instance.new("ImageLabel")
DropShadow.Image = "rbxassetid://1316045217"
DropShadow.ImageColor3 = Color3.new(0, 0, 0)
DropShadow.ImageTransparency = 0.85
DropShadow.Size = UDim2.new(1, 24, 1, 24)
DropShadow.Position = UDim2.new(0, -12, 0, -12)
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(10, 10, 118, 118)
DropShadow.Parent = MainFrame

local function CreateLogMessage(text, color)
    local message = Instance.new("TextLabel")
    message.Text = "• " .. text
    message.TextColor3 = color or Color3.new(1, 1, 1)
    message.Font = Enum.Font.Gotham
    message.TextSize = 13
    message.TextXAlignment = Enum.TextXAlignment.Left
    message.Size = UDim2.new(1, 0, 0, 20)
    message.BackgroundTransparency = 1
    message.Parent = OutputLog
    
    OutputLog.CanvasSize = UDim2.new(0, 0, 0, LogLayout.AbsoluteContentSize.Y)
    OutputLog.CanvasPosition = Vector2.new(0, OutputLog.CanvasSize.Y.Offset)
end

MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
    Size = UDim2.new(0.3, 0, 0.45, 0)
}):Play()

CreateLogMessage("System initialized", Color3.fromRGB(0, 170, 255))
CreateLogMessage("Type 'help' for commands", Color3.fromRGB(170, 170, 170))
