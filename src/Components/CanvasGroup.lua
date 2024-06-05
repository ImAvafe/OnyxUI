local OnyxUI = require(script.Parent.Parent)
local CombineProps = require(OnyxUI.Utils.CombineProps)
local PubTypes = require(script.Parent.Parent.PubTypes)

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	GroupTransparency: PubTypes.CanBeState<number>?,
	GroupColor3: PubTypes.CanBeState<Color3>?,
}

return function(Props: { [any]: any })
	return Base(CombineProps(Props, {
		ClassName = "CanvasGroup",
		Name = "CanvasGroup",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		GroupTransparency = Props.GroupTransparency,
		GroupColor3 = Props.GroupColor3,
	}))
end
