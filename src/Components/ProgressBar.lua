--[=[
		@class ProgressBar
		
		Useful for communicating progress towards goals.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local Frame = require(script.Parent.Frame)
local CanvasGroup = require(script.Parent.CanvasGroup)

export type Props = CanvasGroup.Props & {
	Progress: PubTypes.CanBeState<number>?,
	Color: PubTypes.CanBeState<Color3>?,
	Direction: PubTypes.CanBeState<Enum.FillDirection>?,
	Inverted: PubTypes.CanBeState<boolean>?,
	Length: PubTypes.CanBeState<UDim>?,
}

--[=[
		@within ProgressBar
		@interface ProgressBarProps

		@field ... CanvasGroupProps
		@field ... ProgressBarProps
]=]
return function(Props: Props)
	local Progress = Util.EnsureValue(Props.Progress, "number", 0)
	local Color = Util.EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local Direction = Util.EnsureValue(Props.Direction, "EnumItem", Enum.FillDirection.Horizontal)
	local Inverted = Util.EnsureValue(Props.Inverted, "boolean", false)
	local CornerRadius = Util.EnsureValue(
		Props.CornerRadius,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["Full"]:get())
		end)
	)
	local Length = Util.EnsureValue(
		Props.Length,
		"UDim",
		Computed(function()
			return UDim.new(0, 200)
		end)
	)

	return CanvasGroup(Util.CombineProps(Props, {
		Name = "ProgressBar",
		Size = Computed(function()
			local DirectionValue = Direction:get()
			local LengthValue = Length:get()
			if DirectionValue == Enum.FillDirection.Horizontal then
				return UDim2.new(LengthValue, UDim.new(0, Themer.Theme.TextSize["0.75"]:get()))
			else
				return UDim2.new(UDim.new(0, Themer.Theme.TextSize["0.75"]:get()), LengthValue)
			end
		end),
		AutomaticSize = Enum.AutomaticSize.None,
		BackgroundTransparency = 0,
		BackgroundColor3 = Themer.Theme.Colors.Neutral.Dark,
		CornerRadius = CornerRadius,

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
			},
		},
	}))
end
