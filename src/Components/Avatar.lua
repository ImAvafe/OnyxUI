local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local Modifier = require(OnyxUI.Utils.Modifier)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Image = require(OnyxUI.Components.Image)
local CanvasGroup = require(OnyxUI.Components.CanvasGroup)
local Icon = require(OnyxUI.Components.Icon)

return function(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Avatar")
	Props.Size = EnsureValue(
		Props.Size,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.TextSize["4.5"]:get(), Themer.Theme.TextSize["4.5"]:get())
		end)
	)
	Props.BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Neutral.Dark)
	Props.Image = EnsureValue(Props.Image, "string", nil)
	Props.CornerRadius = EnsureValue(Props.CornerRadius, "number", Themer.Theme.CornerRadius["1"])

	Props.RingEnabled = EnsureValue(Props.RingEnabled, "boolean", false)
	Props.RingColor = EnsureValue(Props.RingColor, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.RingThickness = EnsureValue(Props.RingThickness, "number", Themer.Theme.StrokeThickness["2"])

	Props.IndicatorEnabled = EnsureValue(Props.IndicatorEnabled, "boolean", false)
	Props.IndicatorColor = EnsureValue(Props.IndicatorColor, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.IndicatorCornerRadius = EnsureValue(Props.IndicatorCornerRadius, "number", Themer.Theme.CornerRadius.Full)
	Props.IndicatorImage = EnsureValue(Props.IndicatorImage, "string", nil)

	return Image {
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

		Image = Props.Image,

		[Children] = {
			Modifier.Corner {
				CornerRadius = Computed(function()
					return UDim.new(0, Props.CornerRadius:get())
				end),
			},
			Modifier.Stroke {
				Enabled = Props.RingEnabled,
				Color = Props.RingColor,
				Thickness = Props.RingThickness,
			},

			Computed(function()
				if Props.IndicatorEnabled:get() then
					return CanvasGroup {
						Name = "Indicator",
						BackgroundColor3 = Props.IndicatorColor,
						BackgroundTransparency = 0,
						Size = UDim2.fromScale(0.25, 0.25),
						AutomaticSize = Enum.AutomaticSize.None,
						AnchorPoint = Vector2.new(1, 1),
						Position = UDim2.fromScale(1, 1),

						[Children] = {
							Modifier.AspectRatioConstraint {},
							Modifier.Corner {
								CornerRadius = Computed(function()
									return UDim.new(0, Props.IndicatorCornerRadius:get())
								end),
							},

							Icon {
								Image = Props.IndicatorImage,
								ImageTransparency = Computed(function()
									if Props.IndicatorImage:get() then
										return 0
									else
										return 1
									end
								end),
								Size = UDim2.fromScale(1, 1),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
							},
						},
					}
				end
			end, Fusion.cleanup),

			Props[Children],
		},
	}
end
