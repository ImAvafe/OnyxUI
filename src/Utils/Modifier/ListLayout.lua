local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Computed = Fusion.Computed

type Props = {
	Name: any?,
	Parent: any?,

	Padding: any?,

	FillDirection: any?,
	SortOrder: any?,
	Wraps: any?,

	HorizontalAlignment: any?,
	HorizontalFlex: any?,
	ItemLineAlignment: any?,
	VerticalAlignment: any?,
	VerticalFlex: any?,
}

return function(Props: Props)
	Props.Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end)
	)

	return New "UIListLayout" {
		Name = Props.Name,
		Parent = Props.Parent,
		Padding = Props.Padding,
		FillDirection = Props.FillDirection,
		SortOrder = Props.SortOrder,
		Wraps = Props.Wraps,
		HorizontalAlignment = Props.HorizontalAlignment,
		HorizontalFlex = Props.HorizontalFlex,
		ItemLineAlignment = Props.ItemLineAlignment,
		VerticalAlignment = Props.VerticalAlignment,
		VerticalFlex = Props.VerticalFlex,
	}
end
