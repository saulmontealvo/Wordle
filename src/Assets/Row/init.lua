local Fusion = require(game.ReplicatedStorage.Fusion)
local New,Children,OnEvent,OnChange,State = Fusion.New,Fusion.Children,Fusion.OnEvent,Fusion.OnChange,Fusion.State

local Letter = require(script.Letter)

return function (components)
    return New "Frame" {
        Name = "Row",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0,-0.03, 100),
        Parent = components.Parent,
        [Children] = {
          New "UIPadding" {
            Name = "UIPadding",
            PaddingLeft = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 5),
          },
          
          New "UIListLayout" {
            Name = "UIListLayout",
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
          },
          Letter {
            Name = "One",
            Text=components.First
          },
          Letter {
            Name = "Two",
            Text=components.Second
          },
          Letter {
            Name = "Three",
            Text=components.Third
          },
          Letter {
            Name = "Four",
            Text=components.Fourth
          },
          Letter {
            Name = "Five",
            Text=components.Fifth
          }
        }
    }
end