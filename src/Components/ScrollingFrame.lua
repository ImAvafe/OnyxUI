local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Hydrate = Fusion.Hydrate
local Computed = Fusion.Computed

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	AutomaticCanvasSize: PubTypes.CanBeState<Enum.AutomaticSize>?,
	BottomImage: PubTypes.CanBeState<string>?,
	CanvasPosition: PubTypes.CanBeState<Vector2>?,
	CanvasSize: PubTypes.CanBeState<UDim2>?,
	ElasticBehavior: PubTypes.CanBeState<Enum.ElasticBehavior>?,
	HorizontalScrollBarInset: PubTypes.CanBeState<Enum.ScrollBarInset>?,
	MidImage: PubTypes.CanBeState<string>?,
	ScrollBarImageColor3: PubTypes.CanBeState<Color3>?,
	ScrollBarImageTransparency: PubTypes.CanBeState<number>?,
	ScrollBarThickness: PubTypes.CanBeState<number>?,
	ScrollingDirection: PubTypes.CanBeState<Enum.ScrollingDirection>?,
	ScrollingEnabled: PubTypes.CanBeState<boolean>?,
	TopImage: PubTypes.CanBeState<string>?,
	VerticalScrollBarInset: PubTypes.CanBeState<Enum.ScrollBarInset>?,
	VerticalScrollBarPosition: PubTypes.CanBeState<Enum.VerticalScrollBarPosition>?,
}

return function(Props: Props)
	return Hydrate(Base(CombineProps(Props, {
		ClassName = "ScrollingFrame",
		Name = "ScrollingFrame",
	}))) {
		BottomImage = Computed(function()
			if Themer.Theme.CornerRadius["1"]:get() >= 3 then
				return "rbxassetid://16547643439"
			else
				return "rbxassetid://16547330984"
			end
		end),
		TopImage = Computed(function()
			if Themer.Theme.CornerRadius["1"]:get() >= 3 then
				return "rbxassetid://16547667444"
			else
				return "rbxassetid://16547330984"
			end
		end),
		MidImage = "rbxassetid://16547330984",
		Selectable = false,
		ScrollBarImageColor3 = Themer.Theme.Colors.NeutralContent.Dark,
		ScrollBarImageTransparency = 0,
		ScrollBarThickness = 8,
		BackgroundTransparency = 1,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		AutomaticSize = Enum.AutomaticSize.None,

		CanvasPosition = Props.CanvasPosition,
		CanvasSize = Props.CanvasSize,
		ElasticBehavior = Props.ElasticBehavior,
		HorizontalScrollBarInset = Props.HorizontalScrollBarInset,
		ScrollingEnabled = Props.ScrollingEnabled,
		VerticalScrollBarInset = Props.VerticalScrollBarInset,
		VerticalScrollBarPosition = Props.VerticalScrollBarPosition,
	}
end
