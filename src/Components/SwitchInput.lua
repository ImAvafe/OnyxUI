--[=[
		@class SwitchInput
		
		Useful for letting the user switch things on / off.
]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local ColorUtils = require(Packages.ColorUtils)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local Value = Fusion.Value

local Frame = require(script.Parent.Frame)
local BaseButton = require(script.Parent.BaseButton)

export type Props = Frame.Props & {
	Switched: PubTypes.CanBeState<boolean>?,
	Disabled: PubTypes.CanBeState<boolean>?,
	Color: PubTypes.CanBeState<Color3>?,
}

--[=[
		@within SwitchInput
		@interface SwitchInputProps

		@field ... FrameProps
		@field Switched CanBeState<boolean>?
		@field Disabled CanBeState<boolean>?
		@field Color CanBeState<Color3>?
]=]
return function(Props: Props)
	local Switched = Util.EnsureValue(Props.Switched, "boolean", false)
	local Disabled = Util.EnsureValue(Props.Disabled, "boolean", false)
	local Color = Util.EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local Size = Util.EnsureValue(
		Props.Size,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.TextSize["1"]:get() * 2, Themer.Theme.TextSize["1"]:get())
		end)
	)
	local AutomaticSize = Util.EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.None)

	local IsHolding = Value(false)
	local IsHovering = Value(false)
	local EffectiveColor = Computed(function()
		local ActiveColor
		if Switched:get() then
			ActiveColor = Color:get()
		else
			ActiveColor = Themer.Theme.Colors.NeutralContent.Dark:get()
		end

		if not Disabled:get() then
			if IsHolding:get() then
				return ColorUtils.Emphasize(ActiveColor, Themer.Theme.Emphasis.Regular:get())
			elseif IsHovering:get() then
				return ColorUtils.Emphasize(ActiveColor, Themer.Theme.Emphasis.Light:get())
			end
		end

		return ActiveColor
	end)
	local EffectiveBallColor = Computed(function(): any
		local ActiveColor
		if Switched:get() then
			ActiveColor = Themer.Theme.Colors.Base.Main:get()
		else
			ActiveColor = Themer.Theme.Colors.NeutralContent.Dark:get()
		end

		if not Disabled:get() then
			if IsHolding:get() then
				if not Switched:get() then
					return ColorUtils.Emphasize(ActiveColor, Themer.Theme.Emphasis.Regular:get())
				else
					return ActiveColor
				end
			elseif IsHovering:get() then
				if not Switched:get() then
					return ColorUtils.Emphasize(ActiveColor, Themer.Theme.Emphasis.Light:get())
				else
					return ActiveColor
				end
			end
		end

		return ActiveColor
	end)
	local EffectiveCornerRadius = Util.EnsureValue(
		Props.CornerRadius,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
		end)
	)

	return BaseButton(Util.CombineProps(Props, {
		Name = "SwitchInput",
		Size = Size,
		AutomaticSize = AutomaticSize,
		Disabled = Disabled,
		StrokeEnabled = true,
		StrokeTransparency = Spring(
			Computed(function()
				if Disabled:get() then
					return 0.8
				end
				if Switched:get() then
					return 0
				else
					return 0.6
				end
			end),
			Themer.Theme.SpringSpeed["1"],
			Themer.Theme.SpringDampening["1"]
		),
		StrokeColor = Spring(EffectiveColor, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening["1"]),
		CornerRadius = EffectiveCornerRadius,
		ClickSound = Themer.Theme.Sound.Switch,

		IsHovering = IsHovering,
		IsHolding = IsHolding,
		OnActivated = function()
			Switched:set(not Switched:get())
		end,

		[Children] = {
			Frame {
				Name = "Switch",
				Size = Size,
				AutomaticSize = AutomaticSize,
				BackgroundColor3 = Spring(
					EffectiveColor,
					Themer.Theme.SpringSpeed["1"],
					Themer.Theme.SpringDampening["1"]
				),
				BackgroundTransparency = Spring(
					Computed(function()
						if Switched:get() then
							return 0
						else
							return 1
						end
					end),
					Themer.Theme.SpringSpeed["1"],
					Themer.Theme.SpringDampening["1"]
				),
				Padding = UDim.new(0, 2),
				CornerRadius = EffectiveCornerRadius,

				[Children] = {
					Frame {
						Name = "Ball",
						AnchorPoint = Spring(
							Computed(function()
								if Switched:get() then
									return Vector2.new(1, 0.5)
								else
									return Vector2.new(0, 0.5)
								end
							end),
							Themer.Theme.SpringSpeed["1"],
							Themer.Theme.SpringDampening["1"]
						),
						Position = Spring(
							Computed(function()
								if Switched:get() then
									return UDim2.fromScale(1, 0.5)
								else
									return UDim2.fromScale(0, 0.5)
								end
							end),
							Themer.Theme.SpringSpeed["1"],
							Themer.Theme.SpringDampening["1"]
						),
						Size = UDim2.fromScale(0, 1),
						AutomaticSize = Enum.AutomaticSize.None,
						BackgroundTransparency = Spring(
							Computed(function()
								if Disabled:get() then
									return 0.7
								end
								if Switched:get() then
									return 0
								else
									return 0
								end
							end),
							Themer.Theme.SpringSpeed["1"],
							Themer.Theme.SpringDampening["1"]
						),
						BackgroundColor3 = Spring(
							EffectiveBallColor,
							Themer.Theme.SpringSpeed["1"],
							Themer.Theme.SpringDampening["1"]
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
