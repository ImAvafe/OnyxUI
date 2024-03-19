local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Computed = Fusion.Computed

type Props = {
	Name: any?,
	Parent: any?,
	CornerRadius: any?,
}

return function(Props: Props)
	Props.CornerRadius = EnsureValue(
		Props.CornerRadius,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end)
	)

	return New "UICorner" {
		Name = Props.Name,
		Parent = Props.Parent,
		CornerRadius = Props.CornerRadius,
	}
end
