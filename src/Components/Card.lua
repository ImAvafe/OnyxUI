local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)

export type Props = Frame.Props & {}

return function(Props: Props)
	local Name = EnsureValue(Props.Name, "string", "Card")
	local BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Neutral.Dark)
	local BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 0)
	local CornerRadius = EnsureValue(
		Props.CornerRadius,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end)
	)
	local Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end)
	)
	local PaddingBottom = EnsureValue(Props.PaddingBottom, "UDim", Padding)
	local PaddingLeft = EnsureValue(Props.PaddingLeft, "UDim", Padding)
	local PaddingRight = EnsureValue(Props.PaddingRight, "UDim", Padding)
	local PaddingTop = EnsureValue(Props.PaddingTop, "UDim", Padding)

	return Frame(CombineProps(Props, {
		Name = Name,
		BackgroundColor3 = BackgroundColor3,
		BackgroundTransparency = BackgroundTransparency,
		CornerRadius = CornerRadius,
		PaddingBottom = PaddingBottom,
		PaddingLeft = PaddingLeft,
		PaddingRight = PaddingRight,
		PaddingTop = PaddingTop,
	}))
end
