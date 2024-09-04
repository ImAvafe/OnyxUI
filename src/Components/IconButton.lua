--[=[
		@class IconButton
		
		Like [`Button`](/api/Button), but for a single [`Icon`](/api/Icon).
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Button = require(script.Parent.Button)
local Components = {
	Button = Button,
}

export type Props = Button.Props & {
	Image: Fusion.UsedAs<string>?,
}

--[=[
		@within IconButton
		@interface IconButtonProps

		@field ... ButtonProps
		@field Image Fusion.UsedAs<string>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Image = Util.Fallback(Props.Image, "")
	local Padding = Scope:Computed(function(use)
		return UDim.new(0, use(Theme.Spacing["0.25"]))
	end)

	return Scope:Button(Util.CombineProps(Props, {
		Name = "IconButton",
		PaddingLeft = Padding,
		PaddingRight = Padding,
		PaddingTop = Padding,
		PaddingBottom = Padding,
		Content = Scope:Computed(function(use)
			return { use(Image) }
		end),
	}))
end
