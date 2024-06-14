local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local Frame = require(script.Parent.Frame)

export type Props = Frame.Props & {
	Progress: PubTypes.CanBeState<number>?,
	Color: PubTypes.CanBeState<Color3>?,
	Direction: PubTypes.CanBeState<Enum.FillDirection>?,
	Inverted: PubTypes.CanBeState<boolean>?,
}

return function(Props: Props)
	local Progress = EnsureValue(Props.Progress, "number", 0)
	local Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local Direction = EnsureValue(Props.Direction, "EnumItem", Enum.FillDirection.Horizontal)
	local Inverted = EnsureValue(Props.Inverted, "boolean", false)

	local EffectiveCornerRadius = EnsureValue(
		Props.CornerRadius,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["Full"]:get())
		end)
	)

	return Frame(CombineProps(Props, {
		Name = "ProgressBar",
		Size = Computed(function()
			if Direction:get() == Enum.FillDirection.Horizontal then
				return UDim2.fromOffset(250, Themer.Theme.TextSize["0.75"]:get())
			else
				return UDim2.fromOffset(Themer.Theme.TextSize["0.75"]:get(), 250)
			end
		end),
		AutomaticSize = Enum.AutomaticSize.None,
		BackgroundTransparency = 0,
		BackgroundColor3 = Themer.Theme.Colors.Neutral.Dark,
		CornerRadius = EffectiveCornerRadius,

		[Children] = {
			Frame {
				Name = "ProgressFill",
				Size = Spring(
					Computed(function()
						if Direction:get() == Enum.FillDirection.Horizontal then
							return UDim2.fromScale(Progress:get(), 1)
						else
							return UDim2.fromScale(1, Progress:get())
						end
					end),
					Themer.Theme.SpringSpeed["0.5"],
					Themer.Theme.SpringDampening
				),
				AnchorPoint = Computed(function()
					if Inverted:get() then
						if Direction:get() == Enum.FillDirection.Horizontal then
							return Vector2.new(1, 0)
						else
							return Vector2.new(0, 1)
						end
					else
						return Vector2.new(0, 0)
					end
				end),
				Position = Computed(function()
					if Inverted:get() then
						if Direction:get() == Enum.FillDirection.Horizontal then
							return UDim2.fromScale(1, 0)
						else
							return UDim2.fromScale(0, 1)
						end
					else
						return UDim2.fromScale(0, 0)
					end
				end),
				AutomaticSize = Enum.AutomaticSize.None,
				BackgroundTransparency = 0,
				BackgroundColor3 = Color,
				CornerRadius = EffectiveCornerRadius,
			},
		},
	}))
end
