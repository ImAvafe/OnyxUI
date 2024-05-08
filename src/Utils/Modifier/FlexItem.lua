local OnyxUI = require(script.Parent.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)

local New = Fusion.New

type Props = {
	Name: any?,
	Parent: any?,
	FlexMode: any?,
	ItemLineAlignment: any?,
}

return function(Props: Props)
	return New "UIFlexItem" {
		Name = Props.Name,
		Parent = Props.Parent,
		FlexMode = Props.FlexMode,
		ItemLineAlignment = Props.ItemLineAlignment,
	}
end
