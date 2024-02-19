local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local TextInput = require(script.Parent.TextInput)
local Frame = require(script.Parent.Frame)

return function(Target: Instance)
  local Instance = Frame {
    Parent = Target,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),

    [Children] = {
      New "UIListLayout" {
        Padding = UDim.new(0, 8),
        FillDirection = Enum.FillDirection.Vertical,
      },
      TextInput {
        PlaceholderText = "You can type here!",
      },
      TextInput {
        PlaceholderText = "You can't type here!",
        Disabled = true,
      },
      TextInput {
        PlaceholderText = "Twenty characters only!",
        CharacterLimit = 20,
      },
      TextInput {
        PlaceholderText = "This one wrap-expands!",
        
      },
    }
  }

  return function()
    Instance:Destroy()
  end
end