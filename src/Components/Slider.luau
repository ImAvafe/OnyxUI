--[=[
		@class Slider
		
		For linear selection.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local InnerScope = Fusion.innerScope
local Children = Fusion.Children
local Out = Fusion.Out
local OnEvent = Fusion.OnEvent

local Frame = require(script.Parent.Frame)
local Components = {
	Frame = Frame,
}

function RoundByUnit(Number, Factor)
	return math.floor(Number / Factor + 0.5) * Factor
end

export type Props = Frame.Props & {
	Value: Fusion.UsedAs<number>?,
	Unit: Fusion.UsedAs<number>?,
}

--[=[
		@within Slider
		@interface SliderProps

		@field ... FrameProps
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Value = Scope:EnsureValue(Util.Fallback(Props.Value, 1))
	local Unit = Util.Fallback(Props.Unit, 1 / 100)

	local DragDetector = Scope:Value(nil)
	local AbsoluteSize = Scope:Value(Vector2.new())
	local AbsolutePosition = Scope:Value(Vector2.new())

	local function ProcessDrag(Position: Vector2)
		local AbsoluteSizeValue = Fusion.peek(AbsoluteSize)
		local AbsolutePositionValue = Fusion.peek(AbsolutePosition)
		local UnitValue = Fusion.peek(Unit)

		local RelativePosition = Position.X - AbsolutePositionValue.X

		Value:set(RoundByUnit(math.clamp(RelativePosition / AbsoluteSizeValue.X, 0, 1), UnitValue))
	end

	local Slider = Scope:Hydrate(Scope:Frame(Util.CombineProps(Props, {
		Name = script.Name,
		CornerRadius = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.CornerRadius.Full))
		end),
		BackgroundTransparency = 0,
		BackgroundColor3 = Theme.Colors.Neutral.Main,
		Size = Scope:Computed(function(Use)
			return UDim2.fromOffset(0, Use(Theme.TextSize["0.75"]))
		end),
		AutomaticSize = Enum.AutomaticSize.None,

		[Children] = {
			Scope:Frame {
				Name = "Progress",
				Size = Scope:Computed(function(Use)
					local ValueValue = Use(Value)
					return UDim2.fromScale(ValueValue, 1)
				end),
				BackgroundTransparency = 0,
				BackgroundColor3 = Theme.Colors.Primary.Main,
				CornerRadius = Scope:Computed(function(Use)
					return UDim.new(0, Use(Theme.CornerRadius.Full))
				end),
				AutomaticSize = Enum.AutomaticSize.None,

				[Children] = {
					Scope:Frame {
						Name = "Ball",
						AspectRatio = 1,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromScale(1, 0.5),
						Size = Scope:Computed(function(Use)
							local Offset = Use(Theme.TextSize["1"])
							return UDim2.fromOffset(Offset, Offset)
						end),
						BackgroundTransparency = 0,
						BackgroundColor3 = Theme.Colors.BaseContent.Main,
						CornerRadius = Scope:Computed(function(Use)
							return UDim.new(0, Use(Theme.CornerRadius.Full))
						end),
						StrokeEnabled = true,
						StrokeColor = Theme.Colors.Base.Main,
						StrokeThickness = Theme.StrokeThickness["2"],
						AutomaticSize = Enum.AutomaticSize.None,
					},
				},
			},
			Scope:Frame {
				Name = "Dragger",
				Size = UDim2.fromScale(1, 1),

				[Children] = {
					DragDetector,
				},
			},
		},
	}))) {
		[Out "AbsoluteSize"] = AbsoluteSize,
		[Out "AbsolutePosition"] = AbsolutePosition,
	}

	DragDetector:set(Scope:New "UIDragDetector" {
		DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
		DragAxis = Vector2.new(1, 0),
		BoundingUI = Slider,

		[OnEvent "DragContinue"] = function(Position: Vector2)
			ProcessDrag(Position)
		end,
		[OnEvent "DragStart"] = function(Position: Vector2)
			ProcessDrag(Position)
		end,
	})

	return Slider
end
