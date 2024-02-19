local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)
local Finalize = require(NekaUI.Utils.Finalize)
local EnsureProp = require(NekaUI.Utils.EnsureProp)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Components = script.Parent.Parent.Components
local Frame = require(Components.Frame)
local Text = require(Components.Text)
local IconButton = require(Components.IconButton)

local function TitleBar(Props)
  Props.CloseButtonDisabled = EnsureProp(Props.CloseButtonDisabled, "boolean", false)
  Props.TextSize = EnsureProp(Props.TextSize, "number", 26)
  
  return Finalize(Frame {
    Name = "TitleBar",
    Size = UDim2.fromScale(1, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      Text {
        Name = "Title",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Text = Props.Title,
        TextSize = Props.TextSize,
        AutoLocalize = Props.AutoLocalize,
      },
      Computed(function()
        if not Props.CloseButtonDisabled:get() then
          return IconButton {
            Name = "CloseButton",
            Image = "rbxassetid://13405228418",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.fromScale(1, 0.5),
            Size = UDim2.fromOffset(23, 23),
            OnActivated = function()
              if Props.OnClose then
                Props.OnClose()
              end
            end,
          }
        end
      end, Fusion.cleanup)
    }
  })
end

return TitleBar