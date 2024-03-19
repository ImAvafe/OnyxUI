local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Modifier = require(OnyxUI.Utils.Modifier)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)

return function(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Card")
	Props.BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Neutral.Dark)
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 0)

	Props.CornerRadius = EnsureValue(Props.CornerRadius, "number", Themer.Theme.CornerRadius["1"])
	Props.Padding = EnsureValue(Props.Padding, "UIPadding", Modifier.Padding {})

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
			Modifier.Corner {
				CornerRadius = Computed(function()
					return UDim.new(0, Props.CornerRadius:get())
				end),
			},
			Props.Padding,

			Props[Children],
		},
	}
end
