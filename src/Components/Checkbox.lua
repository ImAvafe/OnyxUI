--[=[
		@class Checkbox
		
		Useful for settings, to-do lists, and anything needing a "Check!"

		![Preview](../components/checkbox.png)
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local Value = Fusion.Value

local BaseButton = require(script.Parent.BaseButton)
local Icon = require(script.Parent.Icon)

export type Props = BaseButton.Props & {
	Checked: PubTypes.CanBeState<boolean>?,
	Icon: PubTypes.CanBeState<string>?,
	Color: PubTypes.CanBeState<Color3>?,
}

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925
local DISABLED_CONTENT_TRANSPARENCY = 0.75

--[=[
		@within Checkbox
		@interface CheckboxProps

		@field ... BaseButtonProps
		@field ... CheckboxProps
]=]
return function(Props: Props)
	local Checked = Util.EnsureValue(Props.Checked, "boolean", false)
	local Disabled = Util.EnsureValue(Props.Disabled, "boolean", false)
	local Color = Util.EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local IconId = Util.EnsureValue(Props.Icon, "string", "rbxassetid://13858821963")

	local IsHovering = Value(false)
	local IsHolding = Value(false)
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

	return BaseButton(Util.CombineProps(Props, {
		Name = "Checkbox",
		BackgroundColor3 = EffectiveColor,
		BackgroundTransparency = Spring(
			Computed(function()
				if Disabled:get() then
					return DISABLED_BACKGROUND_TRANSPARENCY
				else
					if Checked:get() then
						return 0
					else
						return 1
					end
				end
			end),
			Themer.Theme.SpringSpeed["1"],
			Themer.Theme.SpringDampening["1"]
		),
		Disabled = Disabled,
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["0.5"]:get())
		end),
		StrokeEnabled = true,
		StrokeColor = EffectiveColor,
		StrokeTransparency = Computed(function()
			if Disabled:get() then
				return DISABLED_BACKGROUND_TRANSPARENCY
			else
				return 0
			end
		end),

		IsHovering = IsHovering,
		IsHolding = IsHolding,

		OnActivated = function()
			Checked:set(not Checked:get())
		end,

		[Children] = {
			Icon {
				Name = "CheckIcon",
				Image = IconId,
				ImageTransparency = Spring(
					Computed(function()
						if Checked:get() then
							if Disabled:get() then
								return DISABLED_CONTENT_TRANSPARENCY
							else
								return 0
							end
						else
							return 1
						end
					end),
					Themer.Theme.SpringSpeed["1"],
					Themer.Theme.SpringDampening["1"]
				),
				ImageColor3 = Computed(function()
					return ColorUtils.Emphasize(Color:get(), Themer.Theme.Emphasis.Contrast:get())
				end),
				Rotation = Spring(
					Computed(function()
						return (Checked:get() and 0) or -30
					end),
					Themer.Theme.SpringSpeed["1"],
					Themer.Theme.SpringDampening["1"]
				),
			},
		},
	}))
end
