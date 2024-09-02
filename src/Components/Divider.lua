--[=[
		@class Divider
		
		Useful for separating UI into sections.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local PubTypes = require(OnyxUI.Util.PubTypes)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)

type Props = Frame.Props & {
	Length: PubTypes.CanBeState<UDim>?,
	FillDirection: PubTypes.CanBeState<Enum.FillDirection>?,
	Color: PubTypes.CanBeState<Color3>?,
	Transparency: PubTypes.CanBeState<number>?,
	Spacing: PubTypes.CanBeState<UDim>?,
}

--[=[
		@within Divider
		@interface DividerProps

		@field ... FrameProps
		@field Length CanBeState<UDim>?
		@field FillDirection CanBeState<Enum.FillDirection>?
		@field Color CanBeState<Color3>?
		@field Transparency CanBeState<number>?
		@field Spacing CanBeState<UDim>?
]=]
return function(Props: Props)
	local Length = Util.EnsureValue(Props.Length, "UDim", UDim.new(1, 0))
	local FillDirection = Util.EnsureValue(Props.FillDirection, "EnumItem", Enum.FillDirection.Horizontal)
	local Color = Util.EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.BaseContent.Main)
	local Transparency = Util.EnsureValue(Props.Transparency, "number", 0.9)
	local Spacing = Util.EnsureValue(
		Props.Spacing,
		"number",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end)
	)

	local VerticalPadding = Computed(function()
		if FillDirection:get() == Enum.FillDirection.Horizontal then
			return Spacing:get()
		else
			return UDim.new()
		end
	end)
	local HorizontalPadding = Computed(function()
		if FillDirection:get() == Enum.FillDirection.Vertical then
			return Spacing:get()
		else
			return UDim.new()
		end
	end)

	return Frame(Util.CombineProps(Props, {
		Name = "Divider",
		Size = Computed(function()
			if FillDirection:get() == Enum.FillDirection.Horizontal then
				return UDim2.new(Length:get(), UDim.new(0, 0))
			else
				return UDim2.new(UDim.new(0, 0), Length:get())
			end
		end),
		AutomaticSize = Computed(function()
			if FillDirection:get() == Enum.FillDirection.Horizontal then
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
			Frame {
				Name = "DividingLine",
				Size = Computed(function()
					if FillDirection:get() == Enum.FillDirection.Horizontal then
						return UDim2.new(UDim.new(1, 0), UDim.new(0, Themer.Theme.StrokeThickness["1"]:get()))
					else
						return UDim2.new(UDim.new(0, Themer.Theme.StrokeThickness["1"]:get()), UDim.new(1, 0))
					end
				end),
				AutomaticSize = Enum.AutomaticSize.None,
				BackgroundColor3 = Color,
				BackgroundTransparency = Transparency,
			},
		},
	}))
end
