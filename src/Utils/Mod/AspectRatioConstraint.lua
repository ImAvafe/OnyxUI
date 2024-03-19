local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New

type Props = {
	Name: any?,
	Parent: any?,
	AspectRatio: any?,
	AspectType: any?,
	DominantAxis: any?,
}

return function(Props: Props)
	Props.AspectType = EnsureValue(Props.AspectType, "EnumItem", Enum.AspectType.ScaleWithParentSize)

	return New "UIStroke" {
		Name = Props.Name,
		Parent = Props.Parent,
		AspectRatio = Props.AspectRatio,
		AspectType = Props.AspectType,
		DominantAxis = Props.DominantAxis,
	}
end
