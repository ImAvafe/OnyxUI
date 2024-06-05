local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local CombineProps = require(OnyxUI.Utils.CombineProps)
local PubTypes = require(script.Parent.Parent.PubTypes)

local Computed = Fusion.Computed

local Button = require(script.Parent.Button)

export type Props = Button.Props & {
	Image: PubTypes.CanBeState<string>?,
}

local function IconButton(Props: Props)
	local Name = EnsureValue(Props.Name, "string", "IconButton")
	local Image = EnsureValue(Props.Image, "string", "")
	local Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end)
	)
	local PaddingLeft = EnsureValue(Props.PaddingLeft, "UDim", Padding)
	local PaddingRight = EnsureValue(Props.PaddingRight, "UDim", Padding)
	local PaddingTop = EnsureValue(Props.PaddingTop, "UDim", Padding)
	local PaddingBottom = EnsureValue(Props.PaddingBottom, "UDim", Padding)

	return Button(CombineProps(Props, {
		Name = Name,
		PaddingLeft = PaddingLeft,
		PaddingRight = PaddingRight,
		PaddingTop = PaddingTop,
		PaddingBottom = PaddingBottom,
		Contents = Computed(function()
			return { Image:get() }
		end),
	}))
end

return IconButton
