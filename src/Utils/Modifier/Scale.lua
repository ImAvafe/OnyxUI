local OnyxUI = require(script.Parent.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)

local New = Fusion.New

type Props = {
	Name: any?,
	Parent: any?,
	Scale: any?,
}

return function(Props: Props)
	return New "UIScale" {
		Name = Props.Name,
		Parent = Props.Parent,
		Scale = Props.Scale,
	}
end
