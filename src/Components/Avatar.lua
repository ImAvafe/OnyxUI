local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local Colors = require(OnyxUI.Utils.Colors)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local Image = require(script.Parent.Image)
local CanvasGroup = require(script.Parent.CanvasGroup)
local Icon = require(script.Parent.Icon)

export type Props = Image.Props & {
	Image: PubTypes.CanBeState<string>?,
	RingEnabled: PubTypes.CanBeState<boolean>?,
	RingColor: PubTypes.CanBeState<Color3>?,
	RingThickness: PubTypes.CanBeState<number>?,
	IndicatorEnabled: PubTypes.CanBeState<boolean>?,
	IndicatorColor: PubTypes.CanBeState<Color3>?,
	IndicatorIcon: PubTypes.CanBeState<string>?,
	IndicatorIconColor: PubTypes.CanBeState<Color3>?,
	IndicatorCornerRadius: PubTypes.CanBeState<UDim>?,
}

return function(Props: { [any]: any })
	Props.Image = EnsureValue(Props.Image, "string", nil)
	Props.RingEnabled = EnsureValue(Props.RingEnabled, "boolean", false)
	Props.RingColor = EnsureValue(Props.RingColor, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.RingThickness = EnsureValue(Props.RingThickness, "number", Themer.Theme.StrokeThickness["2"])
	Props.IndicatorEnabled = EnsureValue(Props.IndicatorEnabled, "boolean", false)
	Props.IndicatorColor = EnsureValue(Props.IndicatorColor, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.IndicatorCornerRadius = EnsureValue(
		Props.IndicatorCornerRadius,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
		end)
	)
	Props.IndicatorIcon = EnsureValue(Props.IndicatorIcon, "string", nil)
	Props.IndicatorIconColor = EnsureValue(Props.IndicatorIconColor, "Color3", Colors.White)

	return Image(CombineProps(Props, {
		Name = "Avatar",
		Image = Props.Image,
		Size = Computed(function()
			return UDim2.fromOffset(Themer.Theme.TextSize["4.5"]:get(), Themer.Theme.TextSize["4.5"]:get())
		end),
		BackgroundColor3 = Themer.Theme.Colors.Neutral.Dark,
		StrokeEnabled = Props.RingEnabled,
		StrokeColor = Spring(Props.RingColor, Themer.Theme.SpringSpeed["0.5"], Themer.Theme.SpringDampening),
		StrokeThickness = Spring(Props.RingThickness, Themer.Theme.SpringSpeed["0.5"], Themer.Theme.SpringDampening),
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end),

		[Children] = {
			Computed(function()
				if Props.IndicatorEnabled:get() then
					return CanvasGroup {
						Name = "Indicator",
						BackgroundColor3 = Spring(
							Props.IndicatorColor,
							Themer.Theme.SpringSpeed["0.5"],
							Themer.Theme.SpringDampening
						),
						BackgroundTransparency = 0,
						Size = UDim2.fromScale(0.25, 0.25),
						AutomaticSize = Enum.AutomaticSize.None,
						AnchorPoint = Vector2.new(1, 1),
						Position = UDim2.fromScale(1, 1),
						AspectRatio = 1,
						CornerRadius = Props.IndicatorCornerRadius,

						[Children] = {
							Icon {
								Image = Props.IndicatorIcon,
								ImageColor3 = Props.IndicatorIconColor,
								ImageTransparency = Computed(function()
									if Props.IndicatorIcon:get() then
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
				else
					return
				end
			end, Fusion.cleanup),
		},
	}))
end
