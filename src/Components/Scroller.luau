--[=[
		@class Scroller
		
		For making Content scrollable. Equivalent to Roblox's `Scroller` instance.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local InnerScope = Fusion.innerScope

local Base = require(script.Parent.Base)
local Components = {
	Base = Base,
}

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
		@within Scroller
		@interface ScrollerProps

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
return function(Scope: Fusion.Scope<any>, Props: Props): Instance
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local BottomImage = Util.Fallback(
		Props.BottomImage,
		Scope:Computed(function(Use)
			if Use(Theme.CornerRadius["1"]) >= 3 then
				return "rbxassetid://16547643439"
			else
				return "rbxassetid://16547330984"
			end
		end)
	)
	local TopImage = Util.Fallback(
		Props.TopImage,
		Scope:Computed(function(Use)
			if Use(Theme.CornerRadius["1"]) >= 3 then
				return "rbxassetid://16547667444"
			else
				return "rbxassetid://16547330984"
			end
		end)
	)
	local MidImage = Util.Fallback(Props.MidImage, "rbxassetid://16547330984")
	local ScrollBarImageColor3 = Util.Fallback(Props.ScrollBarImageColor3, Theme.Colors.NeutralContent.Dark)
	local ScrollBarImageTransparency = Util.Fallback(Props.ScrollBarImageTransparency, 0)
	local ScrollBarThickness = Util.Fallback(Props.ScrollBarThickness, 8)
	local AutomaticCanvasSize = Util.Fallback(Props.AutomaticCanvasSize, Enum.AutomaticSize.Y)
	local ScrollingDirection = Util.Fallback(Props.ScrollingDirection, Enum.ScrollingDirection.Y)

	return Scope:Hydrate(Scope:Base(Util.CombineProps(Props, {
		ClassName = "ScrollingFrame",
		Name = "Scroller",
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
