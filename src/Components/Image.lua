local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local PubTypes = require(script.Parent.Parent.PubTypes)
local CombineProps = require(script.Parent.Parent.Utils.CombineProps)

local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	Image: PubTypes.CanBeState<string>?,
	FallbackImage: PubTypes.CanBeState<string>?,
	ImageColor3: PubTypes.CanBeState<Color3>?,
	ImageTransparency: PubTypes.CanBeState<number>?,
	ImageRectSize: PubTypes.CanBeState<Vector2>?,
	ResampleMode: PubTypes.CanBeState<Enum.ResamplerMode>?,
	ScaleType: PubTypes.CanBeState<Enum.ScaleType>?,
	SliceCenter: PubTypes.CanBeState<Rect>?,
	SliceScale: PubTypes.CanBeState<number>?,
	TileSize: PubTypes.CanBeState<UDim2>?,
}

return function(Props: Props)
	local FallbackImage = EnsureValue(Props.FallbackImage, "string", "rbxasset://textures/ui/GuiImagePlaceholder.png")
	local Image = EnsureValue(Props.Image, "string", nil)

	local ImageInUse = Computed(function()
		if Image:get() then
			return Image:get()
		else
			return FallbackImage:get()
		end
	end)

	return Hydrate(Base(CombineProps(Props, {
		ClassName = "ImageLabel",
		Name = "Image",
		Size = UDim2.fromOffset(100, 100),
		AutomaticSize = Enum.AutomaticSize.None,
	}))) {
		Image = ImageInUse,
		ImageColor3 = Props.ImageColor3,
		ImageTransparency = Props.ImageTransparency,
		ImageRectSize = Props.ImageRectSize,
		ResampleMode = Props.ResampleMode,
		ScaleType = Props.Scale,
		SliceCenter = Props.SliceCenter,
		SliceScale = Props.SliceScale,
		TileSize = Props.TileSize,
	}
end
