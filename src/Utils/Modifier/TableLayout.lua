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
	FillEmptySpaceColumns: any?,
	FillEmptySpaceRows: any?,
	FillDirection: any?,
	SortOrder: any?,
	MajorAxis: any?,
	HorizontalAlignment: any?,
	VerticalAlignment: any?,
}

return function(Props: Props)
	Props.Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end)
	)

	return New "UIStroke" {
		Name = Props.Name,
		Parent = Props.Parent,
		Padding = Props.Padding,
		FillEmptySpaceColumns = Props.FillEmptySpaceColumns,
		FillEmptySpaceRows = Props.FillEmptySpaceRows,
		FillDirection = Props.FillDirection,
		SortOrder = Props.SortOrder,
		MajorAxis = Props.MajorAxis,
		HorizontalAlignment = Props.HorizontalAlignment,
		VerticalAlignment = Props.VerticalAlignment,
	}
end
