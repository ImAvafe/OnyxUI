local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local PubTypes = require(OnyxUI.Util.PubTypes)
local Fusion = require(OnyxUI.Parent.Fusion)

local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	GroupTransparency: PubTypes.CanBeState<number>?,
	GroupColor3: PubTypes.CanBeState<Color3>?,
}

return function(Props: Props)
	return Hydrate(Base(Util.CombineProps(Props, {
		ClassName = "CanvasGroup",
		Name = "CanvasGroup",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))) {
		GroupTransparency = Props.GroupTransparency,
		GroupColor3 = Props.GroupColor3,
	}
end
