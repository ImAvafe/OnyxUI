local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local CombineProps = require(OnyxUI.Utils.CombineProps)
local PubTypes = require(script.Parent.Parent.PubTypes)

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

return function(Props: Props)
	local Name = EnsureValue(Props.Name, "string", "Divider")
	local Length = EnsureValue(Props.Length, "UDim", UDim.new(1, 0))
	local FillDirection = EnsureValue(Props.FillDirection, "EnumItem", Enum.FillDirection.Horizontal)
	local Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.BaseContent.Main)
	local Transparency = EnsureValue(Props.Transparency, "number", 0.9)
	local Spacing = EnsureValue(
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

	return Frame(CombineProps(Props, {
		Name = Name,
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
