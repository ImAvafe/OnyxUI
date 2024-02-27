local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)

local function MenuFrame(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "MenuFrame")
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.Y)
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 0.015)
	Props.BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Base.Main)

	Props.StrokeColor = EnsureValue(Props.StrokeColor, "Color3", Themer.Theme.Colors.Base.Light)
	Props.StrokeThickness = EnsureValue(Props.StrokeThickness, "number", Themer.Theme.StrokeThickness)
	Props.CornerRadius = EnsureValue(
		Props.CornerRadius,
		"number",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius:get() * 2)
		end)
	)
	Props.Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Space:get() * 3)
		end)
	)

	return New "CanvasGroup" {
		Name = Props.Name,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		ZIndex = Props.ZIndex,
		Parent = Props.Parent,

		GroupTransparency = Props.GroupTransparency,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		[Children] = {
			New "UICorner" {
				CornerRadius = Props.CornerRadius,
			},
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Props.StrokeColor,
				Thickness = Props.StrokeThickness,
			},
			New "UIPadding" {
				PaddingBottom = Props.Padding,
				PaddingLeft = Props.Padding,
				PaddingRight = Props.Padding,
				PaddingTop = Props.Padding,
			},
			Frame {
				Name = "Contents",
				AutomaticSize = Props.AutomaticSize,
				Size = Computed(function()
					local AutomaticSizeScales = {
						[Enum.AutomaticSize.None] = UDim2.fromScale(1, 1),
						[Enum.AutomaticSize.XY] = UDim2.fromScale(0, 0),
						[Enum.AutomaticSize.X] = UDim2.fromScale(0, 1),
						[Enum.AutomaticSize.Y] = UDim2.fromScale(1, 0),
					}
					return AutomaticSizeScales[Props.AutomaticSize:get()]
				end),

				[Children] = Props[Children],
			},

			Props.TopChildren,
		},
	}
end

return MenuFrame
