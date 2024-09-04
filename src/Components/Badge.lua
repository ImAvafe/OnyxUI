--[=[
		@class Badge
		
		Used to inform the user of something's status. E.g. a notification indicator or discount tag.

]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local ColorUtils = require(OnyxUI.Packages.ColorUtils)

local Children = Fusion.Children

local Frame = require(script.Parent.Frame)
local IconText = require(script.Parent.IconText)
local Components = {
	Frame = Frame,
	IconText = IconText,
}

export type Props = Frame.Props & {
	Content: Fusion.UsedAs<{ string }>?,
	ContentWrapped: Fusion.UsedAs<boolean>?,
	Color: Fusion.UsedAs<Color3>?,
	ContentColor: Fusion.UsedAs<Color3>?,
	ContentSize: Fusion.UsedAs<number>?,
	ContentWrapped: Fusion.UsedAs<number>?,
}

--[=[
		@within Badge
		@interface BadgeProps

		@field ... FrameProps
		@field Content Fusion.UsedAs<{ string }>?
		@field ContentWrapped Fusion.UsedAs<boolean>?
		@field Color Fusion.UsedAs<Color3>?
		@field ContentColor Fusion.UsedAs<Color3>?
		@field ContentSize Fusion.UsedAs<number>?
		@field ContentWrapped Fusion.UsedAs<number>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Content = Util.Fallback(Props.Content, {})
	local ContentWrapped = Util.Fallback(Props.ContentWrapped, true)
	local Color = Util.Fallback(Props.Color, Theme.Colors.Base.Main)
	local ContentColor = Util.Fallback(
		Props.ContentColor,

		Scope:Computed(function(use)
			return ColorUtils.Emphasize(Color, use(Theme.Emphasis.Contrast))
		end)
	)
	local ContentSize = Util.Fallback(Props.ContentSize, Theme.TextSize["1"])

	return Scope:Frame(Util.CombineProps(Props, {
		Name = "Badge",
		BackgroundColor3 = Color,
		BackgroundTransparency = 0,
		Padding = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0"]))
		end),
		PaddingLeft = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.5"]))
		end),
		PaddingRight = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.5"]))
		end),
		CornerRadius = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.CornerRadius["2"]))
		end),
		ListEnabled = true,
		ListPadding = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.25"]))
		end),
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
		ListVerticalAlignment = Enum.VerticalAlignment.Center,
		ListWraps = ContentWrapped,

		[Children] = {
			Scope:IconText {
				Content = Content,
				ContentColor = ContentColor,
				ContentSize = ContentSize,
				ContentWrapped = ContentWrapped,
				ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
				ListVerticalAlignment = Enum.VerticalAlignment.Center,
				ListPadding = Scope:Computed(function(use)
					return UDim.new(0, use(Theme.Spacing["0.25"]))
				end),
			},
		},
	}))
end
