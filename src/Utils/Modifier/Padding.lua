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
	PaddingBottom: any?,
	PaddingLeft: any?,
	PaddingRight: any?,
	PaddingTop: any?,
}

return function(Props: Props)
	Props.Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end)
	)
	Props.PaddingBottom = EnsureValue(Props.PaddingBottom, "UDim", Props.Padding)
	Props.PaddingLeft = EnsureValue(Props.PaddingLeft, "UDim", Props.Padding)
	Props.PaddingRight = EnsureValue(Props.PaddingRight, "UDim", Props.Padding)
	Props.PaddingTop = EnsureValue(Props.PaddingTop, "UDim", Props.Padding)

	return New "UIPadding" {
		Name = Props.Name,
		Parent = Props.Parent,
		PaddingBottom = Props.PaddingBottom,
		PaddingLeft = Props.PaddingLeft,
		PaddingRight = Props.PaddingRight,
		PaddingTop = Props.PaddingTop,
	}
end
