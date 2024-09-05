--[=[
		@class Divider
		
		Useful for separating UI into sections.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children

local Frame = require(script.Parent.Frame)
local Components = {
	Frame = Frame,
}

type Props = Frame.Props & {
	Length: Fusion.UsedAs<UDim>?,
	FillDirection: Fusion.UsedAs<Enum.FillDirection>?,
	Color: Fusion.UsedAs<Color3>?,
	Transparency: Fusion.UsedAs<number>?,
	Spacing: Fusion.UsedAs<UDim>?,
}

--[=[
		@within Divider
		@interface DividerProps

		@field ... FrameProps
		@field Length Fusion.UsedAs<UDim>?
		@field FillDirection Fusion.UsedAs<Enum.FillDirection>?
		@field Color Fusion.UsedAs<Color3>?
		@field Transparency Fusion.UsedAs<number>?
		@field Spacing Fusion.UsedAs<UDim>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Length = Util.Fallback(Props.Length, UDim.new(1, 0))
	local FillDirection = Util.Fallback(Props.FillDirection, Enum.FillDirection.Horizontal)
	local Color = Util.Fallback(Props.Color, Theme.Colors.BaseContent.Main)
	local Transparency = Util.Fallback(Props.Transparency, 0.9)
	local Spacing = Util.Fallback(
		Props.Spacing,

		Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["0.5"]))
		end)
	)

	local VerticalPadding = Scope:Computed(function(Use)
		if Use(FillDirection) == Enum.FillDirection.Horizontal then
			return Use(Spacing)
		else
			return UDim.new()
		end
	end)
	local HorizontalPadding = Scope:Computed(function(Use)
		if Use(FillDirection) == Enum.FillDirection.Vertical then
			return Use(Spacing)
		else
			return UDim.new()
		end
	end)

	return Scope:Frame(Util.CombineProps(Props, {
		Name = "Divider",
		Size = Scope:Computed(function(Use)
			if Use(FillDirection) == Enum.FillDirection.Horizontal then
				return UDim2.new(Length, UDim.new(0, 0))
			else
				return UDim2.new(UDim.new(0, 0), Use(Length))
			end
		end),
		AutomaticSize = Scope:Computed(function(Use)
			if Use(FillDirection) == Enum.FillDirection.Horizontal then
				return Enum.AutomaticSize.Y
			else
				return Enum.AutomaticSize.X
			end
		end),
		PaddingTop = VerticalPadding,
		PaddingBottom = VerticalPadding,
		PaddingLeft = HorizontalPadding,
		PaddingRight = HorizontalPadding,

		[Children] = {
			Scope:Frame {
				Name = "DividingLine",
				Size = Scope:Computed(function(Use)
					if Use(FillDirection) == Enum.FillDirection.Horizontal then
						return UDim2.new(UDim.new(1, 0), UDim.new(0, Use(Theme.StrokeThickness["1"])))
					else
						return UDim2.new(UDim.new(0, Use(Theme.StrokeThickness["1"])), UDim.new(1, 0))
					end
				end),
				AutomaticSize = Enum.AutomaticSize.None,
				BackgroundColor3 = Color,
				BackgroundTransparency = Transparency,
			},
		},
	}))
end
