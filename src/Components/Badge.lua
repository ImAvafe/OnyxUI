local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local ForValues = Fusion.ForValues

local Frame = require(OnyxUI.Components.Frame)
local Text = require(OnyxUI.Components.Text)
local Icon = require(OnyxUI.Components.Icon)

return function(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Badge")
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 0)

	Props.Contents = EnsureValue(Props.Contents, "table", {})
	Props.Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Base.Main)
	Props.ContentColor = EnsureValue(
		Props.ContentColor,
		"Color3",
		Computed(function()
			return ColourUtils.Emphasise(Props.Color:get(), 1)
		end)
	)
	Props.ContentSize = EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1"])
	Props.Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end)
	)
	Props.CornerRadius = EnsureValue(Props.CornerRadius, "number", Themer.Theme.CornerRadius["2"])

	return Frame {
		Name = Props.Name,
		Parent = Props.Parent,
		Position = Props.Position,
		Rotation = Props.Rotation,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		Visible = Props.Visible,
		ZIndex = Props.ZIndex,
		LayoutOrder = Props.LayoutOrder,
		ClipsDescendants = Props.ClipsDescendants,
		Active = Props.Active,
		Selectable = Props.Selectable,
		Interactable = Props.Interactable,
		BackgroundTransparency = Props.BackgroundTransparency,

		BackgroundColor3 = Props.Color,

		[Children] = {
			New "UIPadding" {
				PaddingTop = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
				end),
				PaddingBottom = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
				end),
				PaddingLeft = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
				end),
				PaddingRight = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
				end),
			},
			New "UICorner" {
				CornerRadius = Computed(function()
					return UDim.new(0, Props.CornerRadius:get())
				end),
			},
			New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
				end),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},

			ForValues(Props.Contents, function(ContentString: string)
				if string.find(ContentString, "rbxassetid://", 1, true) then
					return Icon {
						Image = ContentString,
						ImageColor3 = Props.ContentColor,
						Size = Computed(function()
							return UDim2.fromOffset(Props.ContentSize:get(), Props.ContentSize:get())
						end),
					}
				else
					return Text {
						Text = ContentString,
						TextColor3 = Props.ContentColor,
						TextSize = Props.ContentSize,
						FontFace = Computed(function()
							return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Bold:get())
						end),
					}
				end
			end, Fusion.cleanup),
		},
	}
end