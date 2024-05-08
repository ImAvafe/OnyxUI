local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Colors = require(OnyxUI.Utils.Colors)

local Children = Fusion.Children

local Image = require(OnyxUI.Components.Image)

local function Text(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "Icon")
	Props.Size = EnsureValue(Props.Size, "number", UDim2.fromOffset(20, 20))
	Props.ImageColor3 = EnsureValue(Props.ImageColor3, "Color3", Colors.White)
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)

	return Image {
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

		Image = Props.Image,
		ImageColor3 = Props.ImageColor3,
		ImageTransparency = Props.ImageTransparency,
		ImageRectSize = Props.ImageRectSize,
		ResampleMode = Props.ResampleMode,
		ScaleType = Props.ScaleType,
		SliceCenter = Props.SliceCenter,
		SliceScale = Props.SliceScale,
		TileSize = Props.TileSize,

		[Children] = Props[Children],
	}
end

return Text
