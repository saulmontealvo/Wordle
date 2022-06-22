local Fusion = require(game.ReplicatedStorage.Fusion)
local New,Children,OnEvent,OnChange,State = Fusion.New,Fusion.Children,Fusion.OnEvent,Fusion.OnChange,Fusion.State

return function (components)
    return New "Frame" {
      Name = components.Name,
      BackgroundColor3 = Color3.fromRGB(255, 255, 255),
      BackgroundTransparency = 1,
      Size = UDim2.fromOffset(65, 65),
    
      [Children] = {
        New "UIStroke" {
          Name = "UIStroke",
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          Color = Color3.fromRGB(102, 102, 102),
          Thickness = 2,
        },
    
        New "TextLabel" {
          Name = "TextLabel",
          Font = Enum.Font.Ubuntu,
          Text = components.Text,
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextScaled = true,
          TextSize = 14,
          TextWrapped = true,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 1,
          Size = UDim2.fromScale(1, 1),
        },
    
        New "UIPadding" {
          Name = "UIPadding",
          PaddingBottom = UDim.new(0, 2),
          PaddingLeft = UDim.new(0, 2),
          PaddingRight = UDim.new(0, 2),
          PaddingTop = UDim.new(0, 2),
        },
      }
    }
end