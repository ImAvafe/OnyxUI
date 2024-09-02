--[=[
		@class Button
		
		A robust button component, supporting text and icons, and multiple variants.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local Value = Fusion.Value

local BaseButton = require(script.Parent.BaseButton)
local IconText = require(script.Parent.IconText)

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925
local DISABLED_CONTENT_TRANSPARENCY = 0.75

export type Props = BaseButton.Props & {
	Disabled: PubTypes.CanBeState<boolean>?,
	Style: PubTypes.CanBeState<string>?,
	Color: PubTypes.CanBeState<Color3>?,
	Content: PubTypes.CanBeState<{ string }>?,
	ContentColor: PubTypes.CanBeState<Color3>?,
	ContentSize: PubTypes.CanBeState<number>?,
	ContentWrapped: PubTypes.CanBeState<boolean>?,
	IsHolding: PubTypes.CanBeState<boolean>?,
}

--[=[
		@within Button
		@interface ButtonProps

		@field ... BaseProps

		@field Disabled CanBeState<boolean>?
		@field Content CanBeState<{ string }>?
		@field Style CanBeState<string>?
		@field Color CanBeState<Color3>?
		@field ContentColor CanBeState<Color3>?
		@field ContentSize CanBeState<number>?
		@field ContentWrapped CanBeState<boolean>?
		@field IsHolding CanBeState<boolean>?
]=]
return function(Props: Props)
	local Disabled = Util.EnsureValue(Props.Disabled, "boolean", false)
	local Content = Util.EnsureValue(Props.Content, "table", {})
	local Style = Util.EnsureValue(Props.Style, "string", "Filled")
	local Color = Util.EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Neutral.Main)
	local ContentColor = Util.EnsureValue(
		Props.ContentColor,
		"Color3",
		Computed(function()
			return ColorUtils.Emphasize(Color:get(), Themer.Theme.Emphasis.Contrast:get())
		end)
	)
	local ContentSize = Util.EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1"])
	local ContentWrapped = Util.EnsureValue(Props.ContentWrapped, "boolean", false)

	local IsHolding = Value(false)
	local IsHovering = Value(false)
	local EffectiveColor = Computed(function()
		if Disabled:get() then
			return Themer.Theme.Colors.BaseContent.Main:get()
		else
			if IsHolding:get() then
				return ColorUtils.Emphasize(Color:get(), Themer.Theme.Emphasis.Regular:get())
			elseif IsHovering:get() then
				return ColorUtils.Emphasize(Color:get(), Themer.Theme.Emphasis.Light:get())
			else
				return Color:get()
			end
		end
	end)
	local EffectiveContentColor = Computed(function()
		if Disabled:get() then
			return Themer.Theme.Colors.BaseContent.Main:get()
		else
			if Style:get() == "Filled" then
				return ContentColor:get()
			elseif Style:get() == "Outlined" then
				return EffectiveColor:get()
			elseif Style:get() == "Ghost" then
				return EffectiveColor:get()
			else
				return ContentColor:get()
			end
		end
	end)
	local EffectiveContentTransparency = Computed(function()
		if Disabled:get() then
			return DISABLED_CONTENT_TRANSPARENCY
		else
			return 0
		end
	end)

	return BaseButton(Util.CombineProps(Props, {
		Name = "Button",
		BackgroundTransparency = Computed(function()
			if Style:get() == "Filled" then
				if Disabled:get() then
					return DISABLED_BACKGROUND_TRANSPARENCY
				else
					return 0
				end
			else
				return 1
			end
		end),
		BackgroundColor3 = Spring(EffectiveColor, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening["1"]),
		PaddingLeft = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
		end),
		PaddingRight = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
		end),
		PaddingTop = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end),
		PaddingBottom = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end),
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end),
		ListEnabled = true,
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
		ListVerticalAlignment = Enum.VerticalAlignment.Center,
		ListWraps = false,
		StrokeEnabled = true,
		StrokeColor = Spring(EffectiveColor, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening["1"]),
		StrokeTransparency = Computed(function()
			if Style:get() == "Ghost" then
				return 1
			elseif Disabled:get() then
				return DISABLED_BACKGROUND_TRANSPARENCY
			else
				return 0
			end
		end),
		IsHolding = IsHolding,
		IsHovering = IsHovering,

		[Children] = {
			IconText {
				Content = Content,
				ContentColor = EffectiveContentColor,
				ContentTransparency = EffectiveContentTransparency,
				ContentSize = ContentSize,
				ContentWrapped = ContentWrapped,
				ListPadding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
				end),
				ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
				ListVerticalAlignment = Enum.VerticalAlignment.Center,
			},
		},
	}))
end
