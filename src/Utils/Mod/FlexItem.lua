local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local New = Fusion.New

type Props = {
	Name: any?,
	Parent: any?,
	FlexMode: any?,
	ItemLineAlignment: any?,
}

return function(Props: Props)
	return New "UIStroke" {
		Name = Props.Name,
		Parent = Props.Parent,
		FlexMode = Props.FlexMode,
		ItemLineAlignment = Props.ItemLineAlignment,
	}
end
