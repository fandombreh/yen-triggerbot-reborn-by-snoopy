getgenv().yenreborn = {
    triggerbot = {
        settings = {
            enabled = true,
            keybind = "C",
            notifications = true,
            delay = 0.035  
        },
        prediction = {
            settings = {
                amount = 7,  
                radius = 15  
            }
        },
        fov = {
            enabled = true,
            size = 8 
        }
    },
    info = {
        safe_mode = true,
        version = "1.0 first release"
    },
 
    custom = {
        enableLogging = false,  
        autoReload = true       
    }
}


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "yen"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = " ¥ - by snoopy "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.Parent = Frame


local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0.5, -100, 0, 60)
toggleButton.Text = "Enable Triggerbot"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.Parent = Frame
toggleButton.MouseButton1Click:Connect(function()
    yen.triggerbot.settings.enabled = not yen.triggerbot.settings.enabled
    toggleButton.Text = yen.triggerbot.settings.enabled and "Disable Triggerbot" or "Enable Triggerbot"
end)


local delayLabel = Instance.new("TextLabel")
delayLabel.Size = UDim2.new(0, 200, 0, 50)
delayLabel.Position = UDim2.new(0.5, -100, 0, 120)
delayLabel.Text = "Trigger Delay: " .. yen.triggerbot.settings.delay
delayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
delayLabel.BackgroundTransparency = 1
delayLabel.Parent = Frame

local delaySlider = Instance.new("Frame")
delaySlider.Size = UDim2.new(0, 200, 0, 10)
delaySlider.Position = UDim2.new(0.5, -100, 0, 170)
delaySlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
delaySlider.Parent = Frame

local sliderHandle = Instance.new("Frame")
sliderHandle.Size = UDim2.new(0, 10, 0, 10)
sliderHandle.Position = UDim2.new(0, (yen.triggerbot.settings.delay * 100), 0, 0)
sliderHandle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
sliderHandle.Parent = delaySlider

local dragging = false
local dragStartPos = nil
local sliderStartPos = nil

sliderHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
        sliderStartPos = sliderHandle.Position.X.Offset
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position.X - dragStartPos.X
        local newPos = math.clamp(sliderStartPos + delta, 0, delaySlider.AbsoluteSize.X)
        sliderHandle.Position = UDim2.new(0, newPos, 0, 0)
        
        
        yen.triggerbot.settings.delay = (newPos / delaySlider.AbsoluteSize.X) * 0.1  -- Max delay of 0.1s
        delayLabel.Text = "Trigger Delay: " .. string.format("%.3f", yen.triggerbot.settings.delay)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local dragInput = nil
local dragStart = nil
local startPos = nil

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = input.Position
        startPos = Frame.Position
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragInput then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input == dragInput then
        dragInput = nil
    end
end)


local function handleTriggerbot()
    local settings = yen.triggerbot.settings
    local keybind = settings.keybind:lower()

    
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode[keybind:upper()] then
            if settings.enabled then
                
                wait(settings.delay)
                
            end
        end
    end)
end


local function applyPrediction()
    local prediction = yen.triggerbot.prediction.settings

end


local function handleFOV()
    local fovSettings = yen.triggerbot.fov
    if fovSettings.enabled then
    
    end
end


loadstring(game:HttpGet("https://raw.githubusercontent.com/dashy2202/utilities/main/triggerbot-v1"))()


handleTriggerbot()
applyPrediction()
handleFOV()
