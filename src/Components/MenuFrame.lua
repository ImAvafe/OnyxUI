local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Computed = Fusion.Computed
local Value = Fusion.Value
local Out = Fusion.Out

local CanvasGroup = require(script.Parent.CanvasGroup)

type Props = CanvasGroup.Props & {}

return function(Props: Props)
	local AutomaticSize = Value(Enum.AutomaticSize.None)

	return CanvasGroup(CombineProps(Props, {
		Name = "MenuFrame",
		GroupTransparency = Props.GroupTransparency,
		BackgroundColor3 = Themer.Theme.Colors.Base.Main,
		BackgroundTransparency = 0,
		Padding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end),
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["3"]:get())
		end),
		StrokeEnabled = true,
		StrokeColor = Themer.Theme.Colors.Neutral.Main,

		[Out "AutomaticSize"] = AutomaticSize,
	}))
end
