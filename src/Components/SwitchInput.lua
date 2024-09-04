--[=[
		@class SwitchInput
		
		Useful for letting the user switch things on / off.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local ColorUtils = require(OnyxUI.Packages.ColorUtils)

local peek = Fusion.peek
local Children = Fusion.Children

local Frame = require(script.Parent.Frame)
local BaseButton = require(script.Parent.BaseButton)
local Components = {
	Frame = Frame,
	BaseButton = BaseButton,
}

export type Props = Frame.Props & {
	Switched: Fusion.UsedAs<boolean>?,
	Disabled: Fusion.UsedAs<boolean>?,
	Color: Fusion.UsedAs<Color3>?,
}

--[=[
		@within SwitchInput
		@interface SwitchInputProps

		@field ... FrameProps
		@field Switched Fusion.UsedAs<boolean>?
		@field Disabled Fusion.UsedAs<boolean>?
		@field Color Fusion.UsedAs<Color3>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Switched = Util.Fallback(Props.Switched, false)
	local Disabled = Util.Fallback(Props.Disabled, false)
	local Color = Util.Fallback(Props.Color, Theme.Colors.Primary.Main)
	local Size = Util.Fallback(
		Props.Size,
		Scope:Computed(function(use)
			return UDim2.fromOffset(use(Theme.TextSize["1"]) * 2, use(Theme.TextSize["1"]))
		end)
	)
	local AutomaticSize = Util.Fallback(Props.AutomaticSize, Enum.AutomaticSize.None)

	local IsHolding = Scope:Value(false)
	local IsHovering = Scope:Value(false)
	local EffectiveColor = Scope:Computed(function(use)
		local ActiveColor
		if use(Switched) then
			ActiveColor = use(Color)
		else
			ActiveColor = use(Theme.Colors.NeutralContent.Dark)
		end

		if not use(Disabled) then
			if use(IsHolding) then
				return ColorUtils.Emphasize(ActiveColor, use(Theme.Emphasis.Regular))
			elseif use(IsHovering) then
				return ColorUtils.Emphasize(ActiveColor, use(Theme.Emphasis.Light))
			end
		end

		return ActiveColor
	end)
	local EffectiveBallColor = Scope:Computed(function(use): any
		local ActiveColor
		if use(Switched) then
			ActiveColor = use(Theme.Colors.Base.Main)
		else
			ActiveColor = use(Theme.Colors.NeutralContent.Dark)
		end

		if not use(Disabled) then
			if use(IsHolding) then
				if not use(Switched) then
					return ColorUtils.Emphasize(ActiveColor, use(Theme.Emphasis.Regular))
				else
					return ActiveColor
				end
			elseif use(IsHovering) then
				if not use(Switched) then
					return ColorUtils.Emphasize(ActiveColor, use(Theme.Emphasis.Light))
				else
					return ActiveColor
				end
			end
		end

		return ActiveColor
	end)
	local EffectiveCornerRadius = Util.Fallback(
		Props.CornerRadius,
		Scope:Computed(function(use)
			return UDim.new(0, use(Theme.CornerRadius.Full))
		end)
	)

	return Scope:BaseButton(Util.CombineProps(Props, {
		Name = "SwitchInput",
		Size = Size,
		AutomaticSize = AutomaticSize,
		Disabled = Disabled,
		StrokeEnabled = true,
		StrokeTransparency = Scope:Spring(
			Scope:Computed(function(use)
				if use(Disabled) then
					return 0.8
				end
				if use(Switched) then
					return 0
				else
					return 0.6
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		StrokeColor = Scope:Spring(EffectiveColor, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
		CornerRadius = EffectiveCornerRadius,
		ClickSound = Theme.Sound.Switch,

		IsHovering = IsHovering,
		IsHolding = IsHolding,
		OnActivated = function()
			Switched:set(not peek(Switched))
		end,

		[Children] = {
			Scope:Frame {
				Name = "Switch",
				Size = Size,
				AutomaticSize = AutomaticSize,
				BackgroundColor3 = Scope:Spring(EffectiveColor, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
				BackgroundTransparency = Scope:Spring(
					Scope:Computed(function(use)
						if use(Switched) then
							return 0
						else
							return 1
						end
					end),
					Theme.SpringSpeed["1"],
					Theme.SpringDampening["1"]
				),
				Padding = UDim.new(0, 2),
				CornerRadius = EffectiveCornerRadius,

				[Children] = {
					Scope:Frame {
						Name = "Ball",
						AnchorPoint = Scope:Spring(
							Scope:Computed(function(use)
								if use(Switched) then
									return Vector2.new(1, 0.5)
								else
									return Vector2.new(0, 0.5)
								end
							end),
							Theme.SpringSpeed["1"],
							Theme.SpringDampening["1"]
						),
						Position = Scope:Spring(
							Scope:Computed(function(use)
								if use(Switched) then
									return UDim2.fromScale(1, 0.5)
								else
									return UDim2.fromScale(0, 0.5)
								end
							end),
							Theme.SpringSpeed["1"],
							Theme.SpringDampening["1"]
						),
						Size = UDim2.fromScale(0, 1),
						AutomaticSize = Enum.AutomaticSize.None,
						BackgroundTransparency = Scope:Spring(
							Scope:Computed(function(use)
								if use(Disabled) then
									return 0.7
								end
								if use(Switched) then
									return 0
								else
									return 0
								end
							end),
							Theme.SpringSpeed["1"],
							Theme.SpringDampening["1"]
						),
						BackgroundColor3 = Scope:Spring(
							EffectiveBallColor,
							Theme.SpringSpeed["1"],
							Theme.SpringDampening["1"]
						),
						AspectRatio = 1,
						AspectType = Enum.AspectType.ScaleWithParentSize,
						DominantAxis = Enum.DominantAxis.Height,
						CornerRadius = EffectiveCornerRadius,
					},
				},
			},
		},
	}, { "Size", "AutomaticSize" }))
end
