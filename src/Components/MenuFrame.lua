local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Modifier = require(OnyxUI.Utils.Modifier)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)

local function MenuFrame(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "MenuFrame")
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.Y)
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 0.015)
	Props.BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Base.Main)

	Props.StrokeColor = EnsureValue(Props.StrokeColor, "Color3", Themer.Theme.Colors.Neutral.Main)
	Props.Padding = EnsureValue(
		Props.Padding,
		"UIPadding",
		Computed(function()
			return Modifier.Padding {
				Padding = UDim.new(0, Themer.Theme.Spacing["1"]:get()),
			}
		end, Fusion.cleanup)
	)

	return New "CanvasGroup" {
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

		GroupTransparency = Props.GroupTransparency,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		[Children] = {
			Props.Padding,
			Modifier.Corner {
				CornerRadius = Computed(function()
					return UDim.new(0, Themer.Theme.CornerRadius["3"]:get())
				end),
			},
			Modifier.Stroke {
				Color = Props.StrokeColor,
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
