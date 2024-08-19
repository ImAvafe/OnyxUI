local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

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
	local BottomImage = EnsureValue(
		Props.BottomImage,
		"string",
		Computed(function()
			if Themer.Theme.CornerRadius["1"]:get() >= 3 then
				return "rbxassetid://16547643439"
			else
				return "rbxassetid://16547330984"
			end
		end)
	)
	local TopImage = EnsureValue(
		Props.TopImage,
		"string",
		Computed(function()
			if Themer.Theme.CornerRadius["1"]:get() >= 3 then
				return "rbxassetid://16547667444"
			else
				return "rbxassetid://16547330984"
			end
		end)
	)
	local MidImage = EnsureValue(Props.MidImage, "string", "rbxassetid://16547330984")
	local ScrollBarImageColor3 =
		EnsureValue(Props.ScrollBarImageColor3, "Color3", Themer.Theme.Colors.NeutralContent.Dark)
	local ScrollBarImageTransparency = EnsureValue(Props.ScrollBarImageTransparency, "number", 0)
	local ScrollBarThickness = EnsureValue(Props.ScrollBarThickness, "number", 8)
	local AutomaticCanvasSize = EnsureValue(Props.AutomaticCanvasSize, "EnumItem", Enum.AutomaticSize.Y)
	local ScrollingDirection = EnsureValue(Props.ScrollingDirection, "EnumItem", Enum.ScrollingDirection.Y)

	return Hydrate(Base(CombineProps(Props, {
		ClassName = "ScrollingFrame",
		Name = "ScrollingFrame",
		Selectable = false,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.None,
	}))) {
		BottomImage = BottomImage,
		TopImage = TopImage,
		MidImage = MidImage,
		ScrollBarImageColor3 = ScrollBarImageColor3,
		ScrollBarImageTransparency = ScrollBarImageTransparency,
		ScrollBarThickness = ScrollBarThickness,
		AutomaticCanvasSize = AutomaticCanvasSize,
		ScrollingDirection = ScrollingDirection,
		CanvasPosition = Props.CanvasPosition,
		CanvasSize = Props.CanvasSize,
		ElasticBehavior = Props.ElasticBehavior,
		HorizontalScrollBarInset = Props.HorizontalScrollBarInset,
		ScrollingEnabled = Props.ScrollingEnabled,
		VerticalScrollBarInset = Props.VerticalScrollBarInset,
		VerticalScrollBarPosition = Props.VerticalScrollBarPosition,
	}
end
