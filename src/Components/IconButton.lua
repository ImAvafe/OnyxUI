local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local Modifier = require(OnyxUI.Utils.Modifier)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Button = require(OnyxUI.Components.Button)

local function IconButton(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "IconButton")

	Props.Image = EnsureValue(Props.Image, "string", "")
	Props.Padding = EnsureValue(
		Props.Padding,
		"UIPadding",
		Modifier.Padding {
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
			end),
		}
	)

	return Button {
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

		Contents = Computed(function()
			return { Props.Image:get() }
		end),
		Padding = Props.Padding,

		Disabled = Props.Disabled,
		Style = Props.Style,
		Color = Props.Color,
		ContrastColor = Props.ContrastColor,
		ContentSize = Props.ContentSize,
		IsHovering = Props.IsHovering,
		IsHolding = Props.IsHolding,
		OnActivated = Props.OnActivated,
		OnMouseEnter = Props.OnMouseEnter,
		OnMouseLeave = Props.OnMouseLeave,
		OnMouseButton1Down = Props.OnMouseButton1Down,
		OnMouseButton1Up = Props.OnMouseButton1Up,
		HoverSound = Props.HoverSound,
		ClickSound = Props.ClickSound,

		[Children] = Props[Children],
	}
end

return IconButton
