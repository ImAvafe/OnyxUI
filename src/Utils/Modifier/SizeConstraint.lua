local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local New = Fusion.New

type Props = {
	Name: any?,
	Parent: any?,
	MaxSize: any?,
	MinSize: any?,
}

return function(Props: Props)
	return New "UISizeConstraint" {
		Name = Props.Name,
		Parent = Props.Parent,
		MaxSize = Props.MaxSize,
		MinSize = Props.MinSize,
	}
end
