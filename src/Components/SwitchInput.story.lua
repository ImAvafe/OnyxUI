local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)

local Children = Fusion.Children

local SwitchInput = require(script.Parent.SwitchInput)
local Text = require(script.Parent.Text)

return function(Target: Instance)
  local Instance = SwitchInput {
    Parent = Target,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),

    [Children] = {
      Text {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Text = "uwu",
        TextSize = 19,
      }
    }
  }

  return function()
    Instance:Destroy()
  end
end