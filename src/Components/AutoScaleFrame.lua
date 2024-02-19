local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)
local EnsureProp = require(NekaUI.Utils.EnsureProp)
local Finalize = require(NekaUI.Utils.Finalize)

local New = Fusion.New
local Value = Fusion.Value
local Computed = Fusion.Computed
local Out = Fusion.Out
local Hydrate = Fusion.Hydrate
local Children = Fusion.Children

local Frame = require(NekaUI.Components.Frame)

return function(Props)
  Props.BaseResolution = EnsureProp(Props.BaseResolution, "Vector2", Vector2.new())
  Props.ScaleClamps = EnsureProp(Props.ScaleClamps, "table", {Min = 0.8, Max = math.huge})
  Props.ScaleMultiplier = EnsureProp(Props.ScaleMultiplier, "number", 1)
  Props.Name = EnsureProp(Props.Name, "string", "AutoScaleFrame")

  local ViewportSize = Value(Vector2.new())
  Hydrate(workspace.CurrentCamera) {
    [Out "ViewportSize"] = ViewportSize
  }

  return Finalize(Frame {
    Name = Props.Name,
    Parent = Props.Parent,
    LayoutOrder = Props.LayoutOrder,
    Position = Props.Position,
    AnchorPoint = Props.AnchorPoint,
    Size = Props.Size,
    AutomaticSize = Props.AutomaticSize or Enum.AutomaticSize.XY,
    ZIndex = Props.ZIndex,

    [Children] = {
      New "UIScale" {
        Scale = Computed(function()
          local Ratio = Props.ScaleMultiplier:get() / math.max((Props.BaseResolution:get().X / ViewportSize:get().X), (Props.BaseResolution:get().Y / ViewportSize:get().Y))
          return math.clamp(Ratio, Props.ScaleClamps:get().Min, Props.ScaleClamps:get().Max)
        end),
      },

      Props[Children]
    }
  })
end