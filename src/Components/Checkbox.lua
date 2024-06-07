local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local ColorUtils = require(OnyxUI.Packages.ColorUtils)
local PubTypes = require(script.Parent.Parent.PubTypes)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

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

	return BaseButton {
		Name = "Checkbox",
		BackgroundColor3 = Computed(function()
			if Disabled:get() then
				return Themer.Theme.Colors.BaseContent.Main:get()
			else
				return Color:get()
			end
		end),
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
		StrokeColor = Computed(function()
			if Disabled:get() then
				return Themer.Theme.Colors.BaseContent.Main:get()
			else
				return Color:get()
			end
		end),
		StrokeTransparency = Computed(function()
			if Disabled:get() then
				return DISABLED_BACKGROUND_TRANSPARENCY
			else
				return 0
			end
		end),

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
					return ColorUtils.Emphasize(Color:get(), 1)
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
	}
end
