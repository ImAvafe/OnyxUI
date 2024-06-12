local OnyxUI = script.Parent.Parent
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Base = require(script.Parent.Base)

export type Props = Base.Props & {}

return function(Props: Props)
	return Base(CombineProps(Props, {
		ClassName = "Frame",
		Name = "Frame",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))
end
