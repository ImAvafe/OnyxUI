--[=[
		@class Checkbox
		
		Useful for settings, to-do lists, and anything needing a "Check!"
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local ColorUtils = require(OnyxUI.Packages.ColorUtils)

local peek = Fusion.peek
local Children = Fusion.Children

local BaseButton = require(script.Parent.BaseButton)
local Icon = require(script.Parent.Icon)
local Components = {
	BaseButton = BaseButton,
	Icon = Icon,
}

export type Props = BaseButton.Props & {
	Checked: Fusion.UsedAs<boolean>?,
	Icon: Fusion.UsedAs<string>?,
	Color: Fusion.UsedAs<Color3>?,
}

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925
local DISABLED_CONTENT_TRANSPARENCY = 0.75

--[=[
		@within Checkbox
		@interface CheckboxProps

		@field ... BaseButtonProps
		@field Checked Fusion.UsedAs<boolean>?
		@field Icon Fusion.UsedAs<string>?
		@field Color Fusion.UsedAs<Color3>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Checked = Scope:EnsureValue(Util.Fallback(Props.Checked, false))
	local Disabled = Util.Fallback(Props.Disabled, false)
	local Color = Util.Fallback(Props.Color, Theme.Colors.Primary.Main)
	local IconId = Util.Fallback(Props.Icon, "rbxassetid://13858821963")

	local IsHovering = Scope:Value(false)
	local IsHolding = Scope:Value(false)
	local EffectiveColor = Scope:Computed(function(use)
		if use(Disabled) then
			return use(Theme.Colors.BaseContent.Main)
		else
			if use(IsHolding) then
				return ColorUtils.Emphasize(use(Color), use(Theme.Emphasis.Regular))
			elseif use(IsHovering) then
				return ColorUtils.Emphasize(use(Color), use(Theme.Emphasis.Light))
			else
				return use(Color)
			end
		end
	end)

	return Scope:BaseButton(Util.CombineProps(Props, {
		Name = "Checkbox",
		BackgroundColor3 = EffectiveColor,
		BackgroundTransparency = Scope:Spring(
			Scope:Computed(function(use)
				if use(Disabled) then
					return DISABLED_BACKGROUND_TRANSPARENCY
				else
					if use(Checked) then
						return 0
					else
						return 1
					end
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		Disabled = Disabled,
		CornerRadius = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.CornerRadius["0.5"]))
		end),
		StrokeEnabled = true,
		StrokeColor = EffectiveColor,
		StrokeTransparency = Scope:Computed(function(use)
			if use(Disabled) then
				return DISABLED_BACKGROUND_TRANSPARENCY
			else
				return 0
			end
		end),

		IsHovering = IsHovering,
		IsHolding = IsHolding,

		OnActivated = function()
			Checked:set(not peek(Checked))
		end,

		[Children] = {
			Scope:Icon {
				Name = "CheckIcon",
				Image = IconId,
				ImageTransparency = Scope:Spring(
					Scope:Computed(function(use)
						if use(Checked) then
							if use(Disabled) then
								return DISABLED_CONTENT_TRANSPARENCY
							else
								return 0
							end
						else
							return 1
						end
					end),
					Theme.SpringSpeed["1"],
					Theme.SpringDampening["1"]
				),
				ImageColor3 = Scope:Computed(function(use)
					return ColorUtils.Emphasize(use(Color), use(Theme.Emphasis.Contrast))
				end),
				Rotation = Scope:Spring(
					Scope:Computed(function(use)
						return (use(Checked) and 0) or -30
					end),
					Theme.SpringSpeed["1"],
					Theme.SpringDampening["1"]
				),
			},
		},
	}))
end
