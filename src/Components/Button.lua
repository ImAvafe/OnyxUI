--[=[
		@class Button
		
		A robust button component, supporting text and icons, and multiple variants.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local ColorUtils = require(OnyxUI.Packages.ColorUtils)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children

local BaseButton = require(script.Parent.BaseButton)
local IconText = require(script.Parent.IconText)
local Components = {
	BaseButton = BaseButton,
	IconText = IconText,
}

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925
local DISABLED_CONTENT_TRANSPARENCY = 0.75

export type Props = BaseButton.Props & {
	Disabled: Fusion.UsedAs<boolean>?,
	Style: Fusion.UsedAs<string>?,
	Color: Fusion.UsedAs<Color3>?,
	Content: Fusion.UsedAs<{ string }>?,
	ContentColor: Fusion.UsedAs<Color3>?,
	ContentSize: Fusion.UsedAs<number>?,
	ContentWrapped: Fusion.UsedAs<boolean>?,
	IsHolding: Fusion.UsedAs<boolean>?,
}

--[=[
		@within Button
		@interface ButtonProps

		@field ... BaseProps

		@field Disabled Fusion.UsedAs<boolean>?
		@field Content Fusion.UsedAs<{ string }>?
		@field Style Fusion.UsedAs<string>?
		@field Color Fusion.UsedAs<Color3>?
		@field ContentColor Fusion.UsedAs<Color3>?
		@field ContentSize Fusion.UsedAs<number>?
		@field ContentWrapped Fusion.UsedAs<boolean>?
		@field IsHolding Fusion.UsedAs<boolean>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Disabled = Util.Fallback(Props.Disabled, false)
	local Content = Util.Fallback(Props.Content, {})
	local Style = Util.Fallback(Props.Style, "Filled")
	local Color = Util.Fallback(Props.Color, Theme.Colors.Neutral.Main)
	local ContentColor = Util.Fallback(
		Props.ContentColor,
		Scope:Computed(function(use)
			return ColorUtils.Emphasize(Color, use(Theme.Emphasis.Contrast))
		end)
	)
	local ContentSize = Util.Fallback(Props.ContentSize, Theme.TextSize["1"])
	local ContentWrapped = Util.Fallback(Props.ContentWrapped, false)

	local IsHolding = Scope:Value(false)
	local IsHovering = Scope:Value(false)
	local EffectiveColor = Scope:Computed(function(use)
		if use(Disabled) then
			return use(Theme.Colors.BaseContent.Main)
		else
			if use(IsHolding) then
				return ColorUtils.Emphasize(Color, use(Theme.Emphasis.Regular))
			elseif use(IsHovering) then
				return ColorUtils.Emphasize(Color, use(Theme.Emphasis.Light))
			else
				return use(Color)
			end
		end
	end)
	local EffectiveContentColor = Scope:Computed(function(use)
		if use(Disabled) then
			return use(Theme.Colors.BaseContent.Main)
		else
			if use(Style) == "Filled" then
				return use(ContentColor)
			elseif use(Style) == "Outlined" then
				return use(EffectiveColor)
			elseif use(Style) == "Ghost" then
				return use(EffectiveColor)
			else
				return use(ContentColor)
			end
		end
	end)
	local EffectiveContentTransparency = Scope:Computed(function(use)
		if use(Disabled) then
			return DISABLED_CONTENT_TRANSPARENCY
		else
			return 0
		end
	end)

	return BaseButton(Util.CombineProps(Props, {
		Name = "Button",
		BackgroundTransparency = Scope:Computed(function(use)
			if use(Style) == "Filled" then
				if use(Disabled) then
					return DISABLED_BACKGROUND_TRANSPARENCY
				else
					return 0
				end
			else
				return 1
			end
		end),
		BackgroundColor3 = Scope:Spring(EffectiveColor, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
		PaddingLeft = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.75"]))
		end),
		PaddingRight = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.75"]))
		end),
		PaddingTop = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.25"]))
		end),
		PaddingBottom = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.25"]))
		end),
		CornerRadius = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.CornerRadius["1"]))
		end),
		ListEnabled = true,
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
		ListVerticalAlignment = Enum.VerticalAlignment.Center,
		ListWraps = false,
		StrokeEnabled = true,
		StrokeColor = Scope:Spring(EffectiveColor, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
		StrokeTransparency = Scope:Computed(function(use)
			if use(Style) == "Ghost" then
				return 1
			elseif use(Disabled) then
				return DISABLED_BACKGROUND_TRANSPARENCY
			else
				return 0
			end
		end),
		IsHolding = IsHolding,
		IsHovering = IsHovering,

		[Children] = {
			Scope:IconText {
				Content = Content,
				ContentColor = EffectiveContentColor,
				ContentTransparency = EffectiveContentTransparency,
				ContentSize = ContentSize,
				ContentWrapped = ContentWrapped,
				ListPadding = Scope:Computed(function(use)
					return UDim.new(0, use(Theme.Spacing["0.25"]))
				end),
				ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
				ListVerticalAlignment = Enum.VerticalAlignment.Center,
			},
		},
	}))
end
