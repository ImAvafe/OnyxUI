local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Modifier = require(OnyxUI.Utils.Modifier)

local New = Fusion.New
local Value = Fusion.Value
local Computed = Fusion.Computed
local Out = Fusion.Out
local Hydrate = Fusion.Hydrate
local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)

return function(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "AutoScaleFrame")

	Props.BaseResolution = EnsureValue(Props.BaseResolution, "Vector2", Vector2.new())
	Props.ScaleClamps = EnsureValue(Props.ScaleClamps, "table", { Min = 0.8, Max = math.huge })
	Props.ScaleMultiplier = EnsureValue(Props.ScaleMultiplier, "number", 1)

	local ViewportSize = Value(Vector2.new())
	Hydrate(game.Workspace.CurrentCamera) {
		[Out "ViewportSize"] = ViewportSize,
	}

	return Frame {
		Name = Props.Name,
		Parent = Props.Parent,
		Position = Props.Position,
		Rotation = Props.Rotation,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		Visible = Props.Visible,
		ZIndex = Props.ZIndex,
		LayoutOrder = Props.LayoutOrder,
		ClipsDescendants = Props.ClipsDescendants,
		Active = Props.Active,
		Selectable = Props.Selectable,
		Interactable = Props.Interactable,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		[Children] = {
			Modifier.Scale {
				Scale = Computed(function()
					local Ratio = Props.ScaleMultiplier:get()
						/ math.max(
							(Props.BaseResolution:get().X / ViewportSize:get().X),
							(Props.BaseResolution:get().Y / ViewportSize:get().Y)
						)
					return math.clamp(Ratio, Props.ScaleClamps:get().Min, Props.ScaleClamps:get().Max)
				end),
			},

			Props[Children],
		},
	}
end
