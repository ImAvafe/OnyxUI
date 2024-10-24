--[=[
		@class Button
		
		A robust button component, supporting text and icons, and multiple variants.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local InnerScope = Fusion.innerScope

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
	SizeVariant: Fusion.UsedAs<"ExtraSmall" | "Small" | "Medium" | "Large" | "ExtraLarge">?,
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
		@field SizeVariant Fusion.UsedAs<"ExtraSmall" | "Small" | "Medium" | "Large" | "ExtraLarge">?
		@field IsHolding Fusion.UsedAs<boolean>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local SizeVariant = Util.Fallback(Props.SizeVariant, "Medium")
	local Disabled = Util.Fallback(Props.Disabled, false)
	local Content = Util.Fallback(Props.Content, {})
	local Style = Util.Fallback(Props.Style, "Filled")
	local Color = Util.Fallback(Props.Color, Theme.Colors.Neutral.Main)
	local ContentColor = Util.Fallback(
		Props.ContentColor,
		Scope:Computed(function(Use)
			return ColorUtils.Emphasize(Use(Color), Use(Theme.Emphasis.Contrast))
		end)
	)
	local ContentSize = Util.Fallback(
		Props.ContentSize,
		Scope:Computed(function(Use)
			local VariantSizes = {
				ExtraSmall = Use(Theme.TextSize["0.875"]),
				Small = Use(Theme.TextSize["1"]),
				Medium = Use(Theme.TextSize["1"]),
				Large = Use(Theme.TextSize["1.25"]),
				ExtraLarge = Use(Theme.TextSize["1.25"]),
			}

			return VariantSizes[Use(SizeVariant)]
		end)
	)
	local ContentWrapped = Util.Fallback(Props.ContentWrapped, false)

	local IsHovering = Scope:EnsureValue(Util.Fallback(Props.IsHovering, false))
	local IsHolding = Scope:EnsureValue(Util.Fallback(Props.IsHolding, false))

	local EffectiveColor = Scope:Computed(function(Use)
		if Use(Disabled) then
			return Use(Theme.Colors.BaseContent.Main)
		else
			if Use(IsHolding) then
				return ColorUtils.Emphasize(Use(Color), Use(Theme.Emphasis.Regular))
			elseif Use(IsHovering) then
				return ColorUtils.Emphasize(Use(Color), Use(Theme.Emphasis.Light))
			else
				return Use(Color)
			end
		end
	end)
	local EffectiveContentColor = Scope:Computed(function(Use)
		if Use(Disabled) then
			return Use(Theme.Colors.BaseContent.Main)
		else
			if Use(Style) == "Filled" then
				return Use(ContentColor)
			elseif Use(Style) == "Outlined" then
				return Use(EffectiveColor)
			elseif Use(Style) == "Ghost" then
				return Use(EffectiveColor)
			else
				return Use(ContentColor)
			end
		end
	end)
	local EffectiveContentTransparency = Scope:Computed(function(Use)
		if Use(Disabled) then
			return DISABLED_CONTENT_TRANSPARENCY
		else
			return 0
		end
	end)
	local PaddingX = Scope:Computed(function(Use)
		local VariantSizes = {
			ExtraSmall = Use(Theme.Spacing["0.25"]),
			Small = Use(Theme.Spacing["0.5"]),
			Medium = Use(Theme.Spacing["0.75"]),
			Large = Use(Theme.Spacing["1"]),
			ExtraLarge = Use(Theme.Spacing["1.5"]),
		}

		return UDim.new(0, VariantSizes[Use(SizeVariant)])
	end)
	local PaddingY = Scope:Computed(function(Use)
		local VariantSizes = {
			ExtraSmall = 0.5,
			Small = 0.75,
			Medium = 1.25,
			Large = 1.5,
			ExtraLarge = 2,
		}

		return UDim.new(0, Use(Theme.Spacing["0.25"]) * VariantSizes[Use(SizeVariant)])
	end)

	return Scope:BaseButton(Util.CombineProps(Props, {
		Name = "Button",
		BackgroundTransparency = Scope:Computed(function(Use)
			if Use(Style) == "Filled" then
				if Use(Disabled) then
					return DISABLED_BACKGROUND_TRANSPARENCY
				else
					return 0
				end
			else
				return 1
			end
		end),
		BackgroundColor3 = Scope:Spring(EffectiveColor, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
		PaddingLeft = PaddingX,
		PaddingRight = PaddingX,
		PaddingTop = PaddingY,
		PaddingBottom = PaddingY,
		CornerRadius = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.CornerRadius["1"]))
		end),
		ListEnabled = true,
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
		ListVerticalAlignment = Enum.VerticalAlignment.Center,
		ListWraps = false,
		StrokeEnabled = true,
		StrokeColor = Scope:Spring(EffectiveColor, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
		StrokeTransparency = Scope:Computed(function(Use)
			if Use(Style) == "Ghost" then
				return 1
			elseif Use(Disabled) then
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
				ListPadding = Scope:Computed(function(Use)
					return UDim.new(0, Use(Theme.Spacing["0.25"]))
				end),
				ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
				ListVerticalAlignment = Enum.VerticalAlignment.Center,
			},
		},
	}))
end
