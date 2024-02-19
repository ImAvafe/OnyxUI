local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)

local Children = Fusion.Children

local TitleBar = require(script.Parent.TitleBar)
local MenuFrame = require(script.Parent.MenuFrame)

return function(Target: Instance)
  local Instance = MenuFrame {
    Parent = Target,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(300, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      TitleBar {
        Title = "Shopping"
      }
    }
  }

  return function()
    Instance:Destroy()
  end
end