local OnyxUI = script.Parent.Parent
local CombineProps = require(script.Parent.Parent.Utils.CombineProps)
local Fusion = require(OnyxUI.Parent.Fusion)

local Computed = Fusion.Computed

local Image = require(script.Parent.Image)
local Themer = require(script.Parent.Parent.Utils.Themer)

export type Props = Image.Props & {}

local function Text(Props: Props)
	return Image(CombineProps(Props, {
		Name = "Icon",
		Size = Computed(function()
			return UDim2.fromOffset(Themer.Theme.TextSize["1"]:get(), Themer.Theme.TextSize["1"]:get())
		end),
		BackgroundTransparency = 1,
	}))
end

return Text
