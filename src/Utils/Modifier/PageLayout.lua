local OnyxUI = require(script.Parent.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Computed = Fusion.Computed

type Props = {
	Name: any?,
	Parent: any?,
	Animated: any?,
	Circular: any?,
	EasingDirection: any?,
	EasingStyle: any?,
	Padding: any?,
	TweenTime: any?,
	FillDirection: any?,
	SortOrder: any?,
	HorizontalAlignment: any?,
	VerticalAlignment: any?,
	GamepadInputEnabled: any?,
	ScrollWheelInputEnabled: any?,
	TouchInputEnabled: any?,
}

return function(Props: Props)
	Props.Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end)
	)

	return New "UIPageLayout" {
		Name = Props.Name,
		Parent = Props.Parent,
		Animated = Props.Animated,
		Circular = Props.Circular,
		EasingDirection = Props.EasingDirection,
		EasingStyle = Props.EasingStyle,
		Padding = Props.Padding,
		TweenTime = Props.TweenTime,
		FillDirection = Props.FillDirection,
		SortOrder = Props.SortOrder,
		HorizontalAlignment = Props.HorizontalAlignment,
		VerticalAlignment = Props.VerticalAlignment,
		GamepadInputEnabled = Props.GamepadInputEnabled,
		ScrollWheelInputEnabled = Props.ScrollWheelInputEnabled,
		TouchInputEnabled = Props.TouchInputEnabled,
	}
end
