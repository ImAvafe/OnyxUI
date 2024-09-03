--[=[
		@class Badge
		
		Used to inform the user of something's status. E.g. a notification indicator or discount tag.

]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local ColorUtils = require(Packages.ColorUtils)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)
local IconText = require(script.Parent.IconText)

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
return function(Props: Props)
	local Content = Util.EnsureValue(Props.Content, "table", {})
	local ContentWrapped = Util.EnsureValue(Props.ContentWrapped, "boolean", true)
	local Color = Util.EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Base.Main)
	local ContentColor = Util.EnsureValue(
		Props.ContentColor,
		"Color3",
		Computed(function()
			return ColorUtils.Emphasize(Color:get(), Themer.Theme.Emphasis.Contrast:get())
		end)
	)
	local ContentSize = Util.EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1"])

	return Frame(Util.CombineProps(Props, {
		Name = "Badge",
		BackgroundColor3 = Color,
		BackgroundTransparency = 0,
		Padding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0"]:get())
		end),
		PaddingLeft = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end),
		PaddingRight = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end),
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["2"]:get())
		end),
		ListEnabled = true,
		ListPadding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end),
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
		ListVerticalAlignment = Enum.VerticalAlignment.Center,
		ListWraps = ContentWrapped,

		[Children] = {
			IconText {
				Content = Content,
				ContentColor = ContentColor,
				ContentSize = ContentSize,
				ContentWrapped = ContentWrapped,
				ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
				ListVerticalAlignment = Enum.VerticalAlignment.Center,
				ListPadding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
				end),
			},
		},
	}))
end
