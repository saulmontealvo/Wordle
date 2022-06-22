--Fusion Imports
local Fusion = require(game.ReplicatedStorage.Fusion)
local New,Children,OnEvent,OnChange,State = Fusion.New,Fusion.Children,Fusion.OnEvent,Fusion.OnChange,Fusion.State
local Computed = Fusion.Computed
-- Services
local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
-- Modules
local IntToWord = require(game.ReplicatedStorage.Modules.IntToWord)
local Config = require(script.Parent.Parent.Config)
-- Assets
local Row = require(game.ReplicatedStorage.Assets.Row)
-- Water mark
print("Game made by Gamerboy72008")



local FirstRow = Row {

}
local SecondRow = Row {

}
local ThirdRow = Row {

}
local FourthRow = Row {

}
local FifthRow = Row {

}
local SixthRow = Row {

}

local CurrentRow = FirstRow

-- Function
local function updateRow(row,value,index)
    if index > 5 then
      --warn("Out of space")
    else
        local word = IntToWord(index)
        local cell = row:FindFirstChild(word)
        if cell then
            cell.TextLabel.Text = string.upper(value)
          else
            warn("cell not found")
        end
    end
end

local function submit(row,text)
  local Test1
  local Test2
  local Test3
  local Test4
  local Test5
   for index,value in pairs(string.split(text,"")) do
      print(index,value)
   end
end

local function IsValidKey(key)
  key = tostring(key)
  key = string.upper(key)
  local result = nil
  pcall(function()
    result = Enum.KeyCode[key]
  end)
  return result
end

local ScreenGui = New "ScreenGui" {
    Name = "GameGUI",
    Parent = Player.PlayerGui,
    IgnoreGuiInset = true,
    [Children] = {
      New "Frame" {
        Size = UDim2.fromScale(1,1),
        BackgroundColor3 = Config.Colors.background,
        [Children] = {
          New "TextLabel" {
            Name = "Wordle",
            Font = Enum.Font.Ubuntu,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextSize = 14,
            TextWrapped = true,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0.501, 0.048),
            Size = UDim2.fromOffset(450, 50),
            Text = "WORDLE",
        },
          New "Frame" {
            Name = "Frame",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.6),
            Size = UDim2.new(0, 450, 1, 0),
            BackgroundColor3 = Config.Colors.background,
            [Children] = {
                New "UIPadding" {
                    Name = "UIPadding",
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10),
                    PaddingTop = UDim.new(0, 10),
                },
                New "UIListLayout" {
                    Name = "UIListLayout",
                    Padding = UDim.new(0, 1),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                },
                FirstRow,
                SecondRow,
                ThirdRow,
                FourthRow,
                FifthRow,
                SixthRow
            }
          },
        }
      }
    }
  }


local Write = ""
local mount = 0

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
  --warn(Write)
   if IsValidKey(UserInputService:GetStringForKeyCode(input.KeyCode)) then
      if mount > 4 then
        warn("Row is full")
      else
          mount = mount+1
          Write = Write..UserInputService:GetStringForKeyCode(input.KeyCode)
          updateRow(CurrentRow,UserInputService:GetStringForKeyCode(input.KeyCode),mount)
          warn("Typed:",Write)
      end 
   end
   
   if input.KeyCode == Enum.KeyCode.Backspace then
      local lastLetter = string.sub(Write,1,#Write-1)
      if mount < 1 then
        warn("Can't remove more letters")
      else
          mount = mount-1
          warn(mount)
      end
      updateRow(CurrentRow,"" ,mount+1)
      Write = lastLetter
   end


   if mount > 4 then
      if input.KeyCode == Enum.KeyCode.C then
        -- function to check if right
        mount = 0
        print("About to submit",Write)
        submit(CurrentRow,Write)
        Write = ""
      end
   end
end)