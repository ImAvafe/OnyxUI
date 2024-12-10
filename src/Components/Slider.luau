--[=[
		@class Slider
		
		For draggable linear selection.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)

local InnerScope = Fusion.innerScope
local Children = Fusion.Children
local Out = Fusion.Out
local OnEvent = Fusion.OnEvent

local BaseButton = require(script.Parent.BaseButton)
local Components = {
	BaseButton = BaseButton,
}

function RoundByUnit(Number, Factor)
	return math.floor(Number / Factor + 0.5) * Factor
end

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925

export type Props = BaseButton.Props & {
	Value: Fusion.UsedAs<number>?,
	Disabled: Fusion.UsedAs<boolean>?,
	Unit: Fusion.UsedAs<number>?,
	Color: Fusion.UsedAs<Color3>?,
}

--[=[
		@within Slider
		@interface SliderProps

		@field ... FrameProps
		@field Value Fusion.UsedAs<number>?
		@field Disabled Fusion.UsedAs<boolean>?
		@field Unit Fusion.UsedAs<number>?
		@field Color Fusion.UsedAs<Color3>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Unit = Util.Fallback(Props.Unit, 1 / 100)
	local Value = Scope:EnsureValue(RoundByUnit(Fusion.peek(Util.Fallback(Props.Value, 1)), Fusion.peek(Unit)))
	local Color = Util.Fallback(Props.Color, Theme.Colors.Primary.Main)
	local Disabled = Util.Fallback(Props.Disabled, false)
	local IsHovering = Scope:EnsureValue(Util.Fallback(Props.IsHovering, false))
	local IsHolding = Scope:EnsureValue(Util.Fallback(Props.IsHolding, false))

	local DragDetector = Scope:Value(nil)
	local AbsoluteSize = Scope:Value(Vector2.new())
	local AbsolutePosition = Scope:Value(Vector2.new())

	local EffectiveColor = Scope:Computed(function(Use)
		if Use(Disabled) then
			return Use(Theme.Colors.BaseContent.Main)
		else
			if Use(IsHolding) then
				return ColorUtils.Emphasize(Use(Color), Use(Theme.Emphasis.Regular))
			elseif Use(IsHovering) then
				return ColorUtils.Emphasize(Use(Color), Use(Theme.Emphasis.Light))
			else
				return Use(Color)
			end
		end
	end)

	local function ProcessDrag(Position: Vector2)
		local AbsoluteSizeValue = Fusion.peek(AbsoluteSize)
		local AbsolutePositionValue = Fusion.peek(AbsolutePosition)
		local UnitValue = Fusion.peek(Unit)

		local RelativePosition = Position.X - AbsolutePositionValue.X

		Value:set(RoundByUnit(math.clamp(RelativePosition / AbsoluteSizeValue.X, 0, 1), UnitValue))
	end

	local Slider = Scope:BaseButton(Util.CombineProps(Props, {
		Name = script.Name,
		CornerRadius = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.CornerRadius.Full))
		end),
		Size = Scope:Computed(function(Use)
			return UDim2.fromOffset(0, Use(Theme.TextSize["1"]))
		end),
		AutomaticSize = Enum.AutomaticSize.Y,
		Disabled = Disabled,
		IsHovering = IsHovering,

		[Children] = {
			DragDetector,
			Scope:Hydrate(Scope:Frame {
				Name = "Progress",
				CornerRadius = Scope:Computed(function(Use)
					return UDim.new(0, Use(Theme.CornerRadius.Full))
				end),
				BackgroundTransparency = 0,
				BackgroundColor3 = Theme.Colors.Neutral.Main,
				Size = Scope:Computed(function(Use)
					return UDim2.new(UDim.new(1, 0), UDim.new(0, Use(Theme.TextSize["0.75"])))
				end),
				FlexMode = Enum.UIFlexMode.Fill,

				[Children] = {
					Scope:Frame {
						Name = "Progress",
						Size = Scope:Computed(function(Use)
							local ValueValue = Use(Value)
							return UDim2.fromScale(ValueValue, 1)
						end),
						BackgroundTransparency = Scope:Computed(function(Use)
							if Use(Disabled) then
								return DISABLED_BACKGROUND_TRANSPARENCY
							else
								return 0
							end
						end),
						BackgroundColor3 = Scope:Spring(
							EffectiveColor,
							Theme.SpringSpeed["1"],
							Theme.SpringDampening["1"]
						),
						CornerRadius = Scope:Computed(function(Use)
							return UDim.new(0, Use(Theme.CornerRadius.Full))
						end),
						AutomaticSize = Enum.AutomaticSize.None,

						[Children] = {
							Scope:Frame {
								Name = "Ball",
								AspectRatio = 1,
								AnchorPoint = Scope:Computed(function(Use)
									local ValueValue = Use(Value)
									return Vector2.new(ValueValue, 0.5)
								end),
								Position = UDim2.fromScale(1, 0.5),
								Size = Scope:Computed(function(Use)
									local Offset = Use(Theme.TextSize["1"])
									return UDim2.fromOffset(Offset, Offset)
								end),
								BackgroundTransparency = 0,
								BackgroundColor3 = Scope:Computed(function(Use)
									if Use(Disabled) then
										return Use(Theme.Colors.Neutral.Main)
									else
										return Use(Theme.Colors.BaseContent.Main)
									end
								end),
								CornerRadius = Scope:Computed(function(Use)
									return UDim.new(0, Use(Theme.CornerRadius.Full))
								end),
								StrokeEnabled = true,
								StrokeColor = Theme.Colors.Neutral.Main,
								StrokeThickness = Theme.StrokeThickness["1"],
								AutomaticSize = Enum.AutomaticSize.None,

								[Children] = {
									Scope:Frame {
										Name = "SmallBall",
										AspectRatio = 1,
										AnchorPoint = Vector2.new(0.5, 0.5),
										Position = UDim2.fromScale(0.5, 0.5),
										Size = Scope:Computed(function(Use)
											local Offset = Use(Theme.TextSize["0.75"])
											return UDim2.fromOffset(Offset, Offset)
										end),
										BackgroundTransparency = 0,
										BackgroundColor3 = Scope:Spring(
											Scope:Computed(function(Use)
												if Use(Disabled) then
													return Use(Theme.Colors.Neutral.Dark)
												else
													return Use(EffectiveColor)
												end
											end),
											Theme.SpringSpeed["1"],
											Theme.SpringDampening["1"]
										),
										CornerRadius = Scope:Computed(function(Use)
											return UDim.new(0, Use(Theme.CornerRadius.Full))
										end),
										AutomaticSize = Enum.AutomaticSize.None,
									},
								},
							},
						},
					},
				},
			}) {
				[Out "AbsoluteSize"] = AbsoluteSize,
				[Out "AbsolutePosition"] = AbsolutePosition,
			},
		},
	}))

	DragDetector:set(Scope:New "UIDragDetector" {
		DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
		DragAxis = Vector2.new(1, 0),
		BoundingUI = Slider,
		Enabled = Scope:Computed(function(Use)
			return not Use(Disabled)
		end),

		[OnEvent "DragContinue"] = function(Position: Vector2)
			ProcessDrag(Position)
		end,
		[OnEvent "DragStart"] = function(Position: Vector2)
			ProcessDrag(Position)
			IsHolding:set(true)
		end,
		[OnEvent "DragEnd"] = function()
			IsHolding:set(false)
		end,
	})

	return Slider
end
