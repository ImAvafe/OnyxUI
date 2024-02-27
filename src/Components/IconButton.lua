local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local BaseButton = require(OnyxUI.Components.BaseButton)
local Icon = require(OnyxUI.Components.Icon)

local function IconButton(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "IconButton")
	Props.ImageColor3 = EnsureValue(Props.ImageColor3, "Color3", Color3.fromRGB(255, 255, 255))
	Props.CornerRadius = EnsureValue(
		Props.CornerRadius,
		"number",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius:get())
		end)
	)

	Props.IsHovering = EnsureValue(Props.IsHovering, "boolean", false)

	return Finalize(BaseButton {
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
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		ImageColor3 = Props.ImageColor3,

		IsHovering = Props.IsHovering,
		OnActivated = Props.OnActivated,

		[Children] = {
			New "UIListLayout" {},
			New "UICorner" {
				CornerRadius = Props.CornerRadius,
			},
			Icon {
				Image = Props.Image,
				Size = Props.Size,
				ImageColor3 = Props.ImageColor3,
			},
		},
	})
end

return IconButton
