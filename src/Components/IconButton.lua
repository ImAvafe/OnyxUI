--[=[
		@class IconButton
		
		Like [`Button`](/api/Button), but for a single [`Icon`](/api/Icon).
]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local PubTypes = require(OnyxUI.Util.PubTypes)

local Computed = Fusion.Computed

local Button = require(script.Parent.Button)

export type Props = Button.Props & {
	Image: PubTypes.CanBeState<string>?,
}

--[=[
		@within IconButton
		@interface IconButtonProps

		@field ... ButtonProps
		@field Image CanBeState<string>?
]=]
return function(Props: Props)
	local Image = Util.EnsureValue(Props.Image, "string", "")
	local Padding = Computed(function()
		return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
	end)

	return Button(Util.CombineProps(Props, {
		Name = "IconButton",
		PaddingLeft = Padding,
		PaddingRight = Padding,
		PaddingTop = Padding,
		PaddingBottom = Padding,
		Content = Computed(function()
			return { Image:get() }
		end),
	}))
end
