local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local PubTypes = require(script.Parent.Parent.PubTypes)
local CombineProps = require(script.Parent.Parent.Utils.CombineProps)

local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

type Props = Base.BaseProps & {
	Image: PubTypes.CanBeState<string>?,
	FallbackImage: PubTypes.CanBeState<string>?,
	ImageColor3: PubTypes.CanBeState<Color3>?,
	ImageTransparency: PubTypes.CanBeState<number>?,
	ImageRectSize: PubTypes.CanBeState<Vector2>,
	ResampleMode: PubTypes.CanBeState<Enum.ResamplerMode>?,
	ScaleType: PubTypes.CanBeState<Enum.ScaleType>?,
	SliceCenter: PubTypes.CanBeState<Rect>?,
	SliceScale: PubTypes.CanBeState<number>?,
	TileSize: PubTypes.CanBeState<UDim2>?,
}

return function(Props: Props)
	local Name = EnsureValue(Props.Name, "string", "Image")
	local Size = EnsureValue(Props.Size, "UDim2", UDim2.fromOffset(100, 100))
	local AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.None)
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
		Name = Name,
		Size = Size,
		AutomaticSize = AutomaticSize,
	}))) {
		Image = ImageInUse,
	}
end
