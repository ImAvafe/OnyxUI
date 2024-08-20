--[=[
		@class Button
		
		A robust button component, supporting text and icons, and multiple variants.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local ColorUtil = require(OnyxUI.Parent.ColorUtil)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Children = Fusion.Children
local ForValues = Fusion.ForValues
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local Value = Fusion.Value

local BaseButton = require(script.Parent.BaseButton)
local Text = require(script.Parent.Text)
local Icon = require(script.Parent.Icon)

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925
local DISABLED_CONTENT_TRANSPARENCY = 0.75

export type Props = BaseButton.Props & {
	Disabled: PubTypes.CanBeState<boolean>?,
	Contents: PubTypes.CanBeState<{ string }>?,
	Style: PubTypes.CanBeState<string>?,
	Color: PubTypes.CanBeState<Color3>?,
	ContentColor: PubTypes.CanBeState<Color3>?,
	ContentSize: PubTypes.CanBeState<number>?,
	IsHolding: PubTypes.CanBeState<boolean>?,
}

--[=[
		@within Button
		@interface ButtonProps

		@field ... BaseProps
		@field ... ButtonProps
]=]
return function(Props: Props)
	local Disabled = Util.EnsureValue(Props.Disabled, "boolean", false)
	local Contents = Util.EnsureValue(Props.Contents, "table", {})
	local Style = Util.EnsureValue(Props.Style, "string", "Filled")
	local Color = Util.EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local ContentColor = Util.EnsureValue(
		Props.ContentColor,
		"Color3",
		Computed(function()
			return ColorUtil.Emphasize(Color:get(), Themer.Theme.Emphasis.Contrast:get())
		end)
	)
	local ContentSize = Util.EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1"])

	local IsHolding = Value(false)
	local IsHovering = Value(false)
	local EffectiveColor = Computed(function()
		if Disabled:get() then
			return Themer.Theme.Colors.BaseContent.Main:get()
		else
			if IsHolding:get() then
				return ColorUtil.Emphasize(Color:get(), Themer.Theme.Emphasis.Regular:get())
			elseif IsHovering:get() then
				return ColorUtil.Emphasize(Color:get(), Themer.Theme.Emphasis.Light:get())
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
		BackgroundColor3 = Spring(EffectiveColor, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening),
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
		ListPadding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end),
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
		ListVerticalAlignment = Enum.VerticalAlignment.Center,
		StrokeEnabled = true,
		StrokeColor = Spring(EffectiveColor, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening),
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
			ForValues(Contents, function(ContentString: string)
				if string.find(ContentString, "rbxassetid://", 1, true) then
					return Icon {
						Image = ContentString,
						ImageColor3 = EffectiveContentColor,
						Size = Computed(function()
							return UDim2.fromOffset(ContentSize:get(), ContentSize:get())
						end),
						ImageTransparency = EffectiveContentTransparency,
					}
				else
					return Text {
						Text = ContentString,
						TextColor3 = EffectiveContentColor,
						TextSize = ContentSize,
						TextTransparency = EffectiveContentTransparency,
						TextWrapped = false,
					}
				end
			end, Fusion.cleanup),
		},
	}))
end
