--[=[
		@class ScrollingFrame
		
		For making Content scrollable. Equivalent to Roblox's `ScrollingFrame` instance.
]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Util = require(OnyxUI.Util)

local Hydrate = Fusion.Hydrate
local Computed = Fusion.Computed

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	AutomaticCanvasSize: Fusion.UsedAs<Enum.AutomaticSize>?,
	BottomImage: Fusion.UsedAs<string>?,
	CanvasPosition: Fusion.UsedAs<Vector2>?,
	CanvasSize: Fusion.UsedAs<UDim2>?,
	ElasticBehavior: Fusion.UsedAs<Enum.ElasticBehavior>?,
	HorizontalScrollBarInset: Fusion.UsedAs<Enum.ScrollBarInset>?,
	MidImage: Fusion.UsedAs<string>?,
	ScrollBarImageColor3: Fusion.UsedAs<Color3>?,
	ScrollBarImageTransparency: Fusion.UsedAs<number>?,
	ScrollBarThickness: Fusion.UsedAs<number>?,
	ScrollingDirection: Fusion.UsedAs<Enum.ScrollingDirection>?,
	ScrollingEnabled: Fusion.UsedAs<boolean>?,
	TopImage: Fusion.UsedAs<string>?,
	VerticalScrollBarInset: Fusion.UsedAs<Enum.ScrollBarInset>?,
	VerticalScrollBarPosition: Fusion.UsedAs<Enum.VerticalScrollBarPosition>?,
}

--[=[
		@within ScrollingFrame
		@interface ScrollingFrameProps

		@field ... BaseProps
		@field AutomaticCanvasSize Fusion.UsedAs<Enum.AutomaticSize>?
		@field BottomImage Fusion.UsedAs<string>?
		@field CanvasPosition Fusion.UsedAs<Vector2>?
		@field CanvasSize Fusion.UsedAs<UDim2>?
		@field ElasticBehavior Fusion.UsedAs<Enum.ElasticBehavior>?
		@field HorizontalScrollBarInset Fusion.UsedAs<Enum.ScrollBarInset>?
		@field MidImage Fusion.UsedAs<string>?
		@field ScrollBarImageColor3 Fusion.UsedAs<Color3>?
		@field ScrollBarImageTransparency Fusion.UsedAs<number>?
		@field ScrollBarThickness Fusion.UsedAs<number>?
		@field ScrollingDirection Fusion.UsedAs<Enum.ScrollingDirection>?
		@field ScrollingEnabled Fusion.UsedAs<boolean>?
		@field TopImage Fusion.UsedAs<string>?
		@field VerticalScrollBarInset Fusion.UsedAs<Enum.ScrollBarInset>?
		@field VerticalScrollBarPosition Fusion.UsedAs<Enum.VerticalScrollBarPosition>?
]=]
return function(Props: Props)
	local BottomImage = Util.EnsureValue(
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
	local TopImage = Util.EnsureValue(
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
	local MidImage = Util.EnsureValue(Props.MidImage, "string", "rbxassetid://16547330984")
	local ScrollBarImageColor3 =
		Util.EnsureValue(Props.ScrollBarImageColor3, "Color3", Themer.Theme.Colors.NeutralContent.Dark)
	local ScrollBarImageTransparency = Util.EnsureValue(Props.ScrollBarImageTransparency, "number", 0)
	local ScrollBarThickness = Util.EnsureValue(Props.ScrollBarThickness, "number", 8)
	local AutomaticCanvasSize = Util.EnsureValue(Props.AutomaticCanvasSize, "EnumItem", Enum.AutomaticSize.Y)
	local ScrollingDirection = Util.EnsureValue(Props.ScrollingDirection, "EnumItem", Enum.ScrollingDirection.Y)

	return Hydrate(Base(Util.CombineProps(Props, {
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
