local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

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

return function(Props: Props)
	local Checked = EnsureValue(Props.Checked, "boolean", false)
	local Disabled = EnsureValue(Props.Disabled, "boolean", false)
	local Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local IconId = EnsureValue(Props.Icon, "string", "rbxassetid://13858821963")

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

	return BaseButton(CombineProps(Props, {
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
			Themer.Theme.SpringDampening
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
					Themer.Theme.SpringDampening
				),
				ImageColor3 = Computed(function()
					return ColorUtils.Emphasize(Color:get(), Themer.Theme.Emphasis.Contrast:get())
				end),
				Rotation = Spring(
					Computed(function()
						return (Checked:get() and 0) or -30
					end),
					Themer.Theme.SpringSpeed["1"],
					Themer.Theme.SpringDampening
				),
			},
		},
	}))
end
