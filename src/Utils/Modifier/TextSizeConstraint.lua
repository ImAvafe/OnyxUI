local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local New = Fusion.New

type Props = {
	Name: any?,
	Parent: any?,
	MaxTextSize: any?,
	MinTextSize: any?,
}

return function(Props: Props)
	return New "UITextSizeConstraint" {
		Name = Props.Name,
		Parent = Props.Parent,
		MaxTextSize = Props.MaxTextSize,
		MinTextSize = Props.MinTextSize,
	}
end
