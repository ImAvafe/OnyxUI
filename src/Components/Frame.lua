local OnyxUI = require(script.Parent.Parent)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Base = require(script.Parent.Base)

export type Props = Base.Props & {}

local function Frame(Props: Props)
	local Name = EnsureValue(Props.Name, "string", "Frame")
	local BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)
	local AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)

	return Base(CombineProps(Props, {
		ClassName = "Frame",
		Name = Name,
		BackgroundTransparency = BackgroundTransparency,
		AutomaticSize = AutomaticSize,
	}))
end

return Frame
