--[=[
		@class ProgressBar
		
		Useful for communicating progress towards goals.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children

local Frame = require(script.Parent.Frame)
local Group = require(script.Parent.Group)
local Components = {
	Frame = Frame,
	Group = Group,
}

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
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Progress = Util.Fallback(Props.Progress, 0)
	local Color = Util.Fallback(Props.Color, Theme.Colors.Primary.Main)
	local Direction = Util.Fallback(Props.Direction, Enum.FillDirection.Horizontal)
	local Inverted = Util.Fallback(Props.Inverted, false)
	local CornerRadius = Util.Fallback(
		Props.CornerRadius,
		Scope:Computed(function(use)
			return UDim.new(0, use(Theme.CornerRadius["Full"]))
		end)
	)
	local Length = Util.Fallback(
		Props.Length,
		Scope:Computed(function()
			return UDim.new(0, 200)
		end)
	)

	return Scope:Group(Util.CombineProps(Props, {
		Name = "ProgressBar",
		Size = Scope:Computed(function(use)
			local DirectionValue = use(Direction)
			local LengthValue = use(Length)
			if DirectionValue == Enum.FillDirection.Horizontal then
				return UDim2.new(LengthValue, UDim.new(0, use(Theme.TextSize["0.75"])))
			else
				return UDim2.new(UDim.new(0, use(Theme.TextSize["0.75"])), LengthValue)
			end
		end),
		AutomaticSize = Enum.AutomaticSize.None,
		BackgroundTransparency = 0,
		BackgroundColor3 = Theme.Colors.Neutral.Dark,
		CornerRadius = CornerRadius,

		[Children] = {
			Scope:Frame {
				Name = "ProgressFill",
				Size = Scope:Spring(
					Scope:Computed(function(use)
						if use(Direction) == Enum.FillDirection.Horizontal then
							return UDim2.fromScale(use(Progress), 1)
						else
							return UDim2.fromScale(1, use(Progress))
						end
					end),
					Theme.SpringSpeed["0.5"],
					Theme.SpringDampening["1"]
				),
				AnchorPoint = Scope:Computed(function(use)
					if use(Inverted) then
						if use(Direction) == Enum.FillDirection.Horizontal then
							return Vector2.new(1, 0)
						else
							return Vector2.new(0, 1)
						end
					else
						return Vector2.new(0, 0)
					end
				end),
				Position = Scope:Computed(function(use)
					if use(Inverted) then
						if use(Direction) == Enum.FillDirection.Horizontal then
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
