local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

return function(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "Image")
	Props.Size = EnsureValue(Props.Size, "UDim2", UDim2.fromOffset(100, 100))
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.None)
	Props.FallbackImage = EnsureValue(Props.FallbackImage, "string", "rbxasset://textures/ui/GuiImagePlaceholder.png")
	Props.Image = EnsureValue(Props.Image, "string", nil)

	local Image = Computed(function()
		if Props.Image:get() then
			return Props.Image:get()
		else
			return Props.FallbackImage:get()
		end
	end)

	return New "ImageLabel" {
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
		ImageTransparency = Props.ImageTransparency,
		ImageRectSize = Props.ImageRectSize,
		ResampleMode = Props.ResampleMode,
		ScaleType = Props.ScaleType,
		SliceCenter = Props.SliceCenter,
		SliceScale = Props.SliceScale,
		TileSize = Props.TileSize,

		Image = Image,

		[Children] = Props[Children],
	}
end
