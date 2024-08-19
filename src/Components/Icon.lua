local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(script.Parent.Parent.Themer)

local Computed = Fusion.Computed

local Image = require(script.Parent.Image)

export type Props = Image.Props & {}

return function(Props: Props)
	return Image(Util.CombineProps(Props, {
		Name = "Icon",
		Size = Computed(function()
			return UDim2.fromOffset(Themer.Theme.TextSize["1"]:get(), Themer.Theme.TextSize["1"]:get())
		end),
		BackgroundTransparency = 1,
	}))
end
