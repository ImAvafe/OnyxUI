--[=[
		@class ProgressBar
		
		Useful for communicating progress towards goals.
]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local Frame = require(script.Parent.Frame)
local Group = require(script.Parent.Group)

export type Props = Group.Props & {
	Progress: Fusion.UsedAs<number>?,
	Color: Fusion.UsedAs<Color3>?,
	Direction: Fusion.UsedAs<Enum.FillDirection>?,
	Inverted: Fusion.UsedAs<boolean>?,
	Length: Fusion.UsedAs<UDim>?,
}

--[=[
		@within ProgressBar
		@interface ProgressBarProps

		@field ... GroupProps
		@field Progress Fusion.UsedAs<number>?
		@field Color Fusion.UsedAs<Color3>?
		@field Direction Fusion.UsedAs<Enum.FillDirection>?
		@field Inverted Fusion.UsedAs<boolean>?
		@field Length Fusion.UsedAs<UDim>?
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

	return Group(Util.CombineProps(Props, {
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
					Themer.Theme.SpringDampening["1"]
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
