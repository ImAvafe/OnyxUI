local ContentProvider = game:GetService("ContentProvider")

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children
local Observer = Fusion.Observer
local Cleanup = Fusion.Cleanup
local Value = Fusion.Value

return function(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "Image")
	Props.Size = EnsureValue(Props.Size, "UDim2", UDim2.fromOffset(100, 100))
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.None)
	Props.Image = EnsureValue(Props.Image, "string", nil)
	Props.FallbackImage = EnsureValue(Props.FallbackImage, "string", "rbxasset://textures/ui/GuiImagePlaceholder.png")

	local Image = Value("rbxasset://textures/ui/GuiImagePlaceholder.png")

	local function UpdateImage()
		if Props.Image:get() then
			local Success, Result = pcall(function()
				return ContentProvider:PreloadAsync(
					{ Props.Image:get() },
					function(AssetId: string, FetchStatus: EnumItem)
						if FetchStatus == Enum.AssetFetchStatus.Success then
							Image:set(AssetId)
						else
							Image:set(Props.FallbackImage:get())
						end
					end
				)
			end)
			if not Success then
				Image:set(Props.FallbackImage:get())

				warn(Result)
			end
		else
			Image:set(Props.FallbackImage:get())
		end
	end
	local ImageObserver = Observer(Props.Image):onChange(UpdateImage)
	task.spawn(UpdateImage)

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

		[Cleanup] = function()
			ImageObserver()
		end,

		[Children] = Props[Children],
	}
end
