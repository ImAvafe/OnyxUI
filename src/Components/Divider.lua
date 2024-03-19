local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local Modifier = require(OnyxUI.Utils.Modifier)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)

return function(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Divider")

	Props.Length = EnsureValue(Props.Length, "UDim", UDim.new(1, 0))
	Props.FillDirection = EnsureValue(Props.FillDirection, "EnumItem", Enum.FillDirection.Horizontal)
	Props.Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.BaseContent.Main)
	Props.Transparency = EnsureValue(Props.Transparency, "number", 0.9)
	Props.Spacing = EnsureValue(Props.Spacing, "number", Themer.Theme.Spacing["0.5"])

	local VerticalPadding = Computed(function()
		if Props.FillDirection:get() == Enum.FillDirection.Horizontal then
			return UDim.new(0, Props.Spacing:get())
		else
			return UDim.new()
		end
	end)
	local HorizontalPadding = Computed(function()
		if Props.FillDirection:get() == Enum.FillDirection.Vertical then
			return UDim.new(0, Props.Spacing:get())
		else
			return UDim.new()
		end
	end)

	return Frame {
		Name = Props.Name,
		Parent = Props.Parent,
		Position = Props.Position,
		Rotation = Props.Rotation,
		AnchorPoint = Props.AnchorPoint,
		Visible = Props.Visible,
		ZIndex = Props.ZIndex,
		LayoutOrder = Props.LayoutOrder,
		ClipsDescendants = Props.ClipsDescendants,
		Active = Props.Active,
		Selectable = Props.Selectable,
		Interactable = Props.Interactable,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		Size = Computed(function()
			if Props.FillDirection:get() == Enum.FillDirection.Horizontal then
				return UDim2.new(Props.Length:get(), UDim.new(0, 0))
			else
				return UDim2.new(UDim.new(0, 0), Props.Length:get())
			end
		end),
		AutomaticSize = Computed(function()
			if Props.FillDirection:get() == Enum.FillDirection.Horizontal then
				return Enum.AutomaticSize.Y
			else
				return Enum.AutomaticSize.X
			end
		end),

		[Children] = {
			Modifier.Padding {
				PaddingTop = VerticalPadding,
				PaddingBottom = VerticalPadding,
				PaddingLeft = HorizontalPadding,
				PaddingRight = HorizontalPadding,
			},

			Frame {
				Name = "DividingLine",
				Size = Computed(function()
					if Props.FillDirection:get() == Enum.FillDirection.Horizontal then
						return UDim2.new(UDim.new(1, 0), UDim.new(0, Themer.Theme.StrokeThickness["1"]:get()))
					else
						return UDim2.new(UDim.new(0, Themer.Theme.StrokeThickness["1"]:get()), UDim.new(1, 0))
					end
				end),
				AutomaticSize = Enum.AutomaticSize.None,
				BackgroundColor3 = Props.Color,
				BackgroundTransparency = Props.Transparency,
			},
		},
	}
end
