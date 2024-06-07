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

return IconButton
