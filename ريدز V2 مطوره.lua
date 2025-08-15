local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local externalBtn = Instance.new("ImageButton")
externalBtn.Parent = PlayerGui
externalBtn.Size = UDim2.fromOffset(50, 50)
externalBtn.Position = UDim2.new(0, 50, 0.5, -25)
externalBtn.BackgroundTransparency = 0.3
externalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
externalBtn.Image = "rbxassetid://98360849741395"
Instance.new("UICorner", externalBtn).CornerRadius = UDim.new(0, 10)

local externalStroke = Instance.new("UIStroke", externalBtn)
externalStroke.Thickness = 3
externalStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function()
    local hue = 0
    while true do
        externalStroke.Color = Color3.fromHSV(hue, 1, 1)
        hue = hue + 0.01
        if hue > 1 then hue = 0 end
        task.wait(0.02)
    end
end)

local dragging
externalBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)
externalBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
externalBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local mouse = player:GetMouse()
        externalBtn.Position = UDim2.new(0, mouse.X - externalBtn.AbsoluteSize.X/2, 0, mouse.Y - externalBtn.AbsoluteSize.Y/2)
    end
end)

externalBtn.Activated:Connect(function()
    local redzlib
    if game:GetService("ReplicatedStorage"):FindFirstChild("RedzLibModule") then
        redzlib = require(game.ReplicatedStorage.RedzLibModule)
    else
        local url = "https://raw.githubusercontent.com/redz9999/redzlib/main/redzlib.lua"
        redzlib = loadstring(game:HttpGet(url))()
    end

    local Window = redzlib:MakeWindow({
        Title = "redz Hub : Blox Fruits",
        SubTitle = "by redz9999",
        SaveFolder = "testando | redz lib v5.lua"
    })

    Window:AddMinimizeButton({
        Button = {
            Image = "rbxassetid://71014873973869",
            BackgroundTransparency = 0
        },
        Corner = {
            CornerRadius = UDim.new(0, 35)
        }
    })
end)
