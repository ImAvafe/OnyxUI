--[=[
		@class Badge
		
		Used to inform the user of something's status. E.g. a notification indicator or discount tag.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)
local IconText = require(script.Parent.IconText)

export type Props = Frame.Props & {
	Contents: PubTypes.CanBeState<{ string }>?,
	ContentsWrapped: PubTypes.CanBeState<boolean>?,
	Color: PubTypes.CanBeState<Color3>?,
	ContentColor: PubTypes.CanBeState<Color3>?,
	ContentSize: PubTypes.CanBeState<number>?,
}

--[=[
		@within Badge
		@interface BadgeProps

		@field ... FrameProps
		@field ... BadgeProps
]=]
return function(Props: Props)
	local Contents = Util.EnsureValue(Props.Contents, "table", {})
	local ContentWraps = Util.EnsureValue(Props.ContentsWrapped, "boolean", true)
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
		ListWraps = ContentWraps,

		[Children] = {
			IconText {
				Content = Contents,
				ContentColor = ContentColor,
				ContentSize = ContentSize,
				ContentWraps = ContentWraps,
				ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
				ListVerticalAlignment = Enum.VerticalAlignment.Center,
				ListPadding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
				end),
			},
		},
	}))
end
