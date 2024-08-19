local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)

local Base = require(script.Parent.Base)

export type Props = Base.Props & {}

return function(Props: Props)
	return Base(Util.CombineProps(Props, {
		ClassName = "Frame",
		Name = "Frame",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))
end
