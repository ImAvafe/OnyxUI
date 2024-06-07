local OnyxUI = require(script.Parent.Parent)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Base = require(script.Parent.Base)

export type Props = Base.Props & {}

local function Frame(Props: Props)
	return Base(CombineProps(Props, {
		ClassName = "Frame",
		Name = "Frame",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))
end

return Frame
