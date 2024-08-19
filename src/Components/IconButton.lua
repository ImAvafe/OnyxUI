local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Themer)
local CombineProps = require(OnyxUI.Utils.CombineProps)
local PubTypes = require(OnyxUI.Utils.PubTypes)

local Computed = Fusion.Computed

local Button = require(script.Parent.Button)

export type Props = Button.Props & {
	Image: PubTypes.CanBeState<string>?,
	Disabled: PubTypes.CanBeState<boolean>?,
	Style: PubTypes.CanBeState<string>?,
	Color: PubTypes.CanBeState<Color3>?,
	ContentColor: PubTypes.CanBeState<Color3>?,
	ContentSize: PubTypes.CanBeState<number>?,
	IsHolding: PubTypes.CanBeState<boolean>?,
}

return function(Props: Props)
	local Image = EnsureValue(Props.Image, "string", "")
	local Padding = Computed(function()
		return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
	end)

	return Button(CombineProps(Props, {
		Name = "IconButton",
		PaddingLeft = Padding,
		PaddingRight = Padding,
		PaddingTop = Padding,
		PaddingBottom = Padding,
		Contents = Computed(function()
			return { Image:get() }
		end),
	}))
end
