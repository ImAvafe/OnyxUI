local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)

export type Props = Frame.Props & {}

return function(Props: Props)
	return Frame(CombineProps(Props, {
		Name = "Card",
		BackgroundColor3 = Themer.Theme.Colors.Neutral.Dark,
		BackgroundTransparency = 0,
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end),
		Padding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end),
	}))
end
