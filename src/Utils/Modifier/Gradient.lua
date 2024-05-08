local OnyxUI = require(script.Parent.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)

local New = Fusion.New

type Props = {
	Name: any?,
	Parent: any?,
	Enabled: any?,
	Color: any?,
	Offset: any?,
	Rotation: any?,
	Transparency: any?,
}

return function(Props: Props)
	return New "UIGradient" {
		Name = Props.Name,
		Parent = Props.Parent,
		Enabled = Props.Enabled,
		Color = Props.Color,
		Offset = Props.Offset,
		Rotation = Props.Rotation,
		Transparency = Props.Transparency,
	}
end
