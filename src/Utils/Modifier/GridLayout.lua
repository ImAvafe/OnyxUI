local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Computed = Fusion.Computed

type Props = {
	Name: any?,
	Parent: any?,
	CellPadding: any?,
	CellSize: any?,
	FillDirection: any?,
	FillDirectionMaxCells: any?,
	SortOrder: any?,
	StartCorner: any?,
	HorizontalAlignment: any?,
	VerticalAlignment: any?,
}

return function(Props: Props)
	Props.CellPadding = EnsureValue(
		Props.CellPadding,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.Spacing["1"]:get(), Themer.Theme.Spacing["1"]:get())
		end)
	)
	Props.CellSize = EnsureValue(
		Props.CellSize,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.Spacing["6"]:get(), Themer.Theme.Spacing["6"]:get())
		end)
	)

	return New "UIGridLayout" {
		Name = Props.Name,
		Parent = Props.Parent,
		CellPadding = Props.CellPadding,
		CellSize = Props.CellSize,
		FillDirection = Props.FillDirection,
		FillDirectionMaxCells = Props.FillDirectionMaxCells,
		SortOrder = Props.SortOrder,
		StartCorner = Props.StartCorner,
		HorizontalAlignment = Props.HorizontalAlignment,
		VerticalAlignment = Props.VerticalAlignment,
	}
end
