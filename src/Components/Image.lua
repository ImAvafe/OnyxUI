--[=[
		@class Image
		
		Equivalent to Roblox's `ImageLabel`.
]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)

local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	Image: Fusion.UsedAs<string>?,
	FallbackImage: Fusion.UsedAs<string>?,
	ImageColor3: Fusion.UsedAs<Color3>?,
	ImageTransparency: Fusion.UsedAs<number>?,
	ImageRectSize: Fusion.UsedAs<Vector2>?,
	ResampleMode: Fusion.UsedAs<Enum.ResamplerMode>?,
	ScaleType: Fusion.UsedAs<Enum.ScaleType>?,
	SliceCenter: Fusion.UsedAs<Rect>?,
	SliceScale: Fusion.UsedAs<number>?,
	TileSize: Fusion.UsedAs<UDim2>?,
}

--[=[
		@within Image
		@interface ImageProps

		@field ... BaseProps
		@field Image Fusion.UsedAs<string>?
		@field FallbackImage Fusion.UsedAs<string>?
		@field ImageColor3 Fusion.UsedAs<Color3>?
		@field ImageTransparency Fusion.UsedAs<number>?
		@field ImageRectSize Fusion.UsedAs<Vector2>?
		@field ResampleMode Fusion.UsedAs<Enum.ResamplerMode>?
		@field ScaleType Fusion.UsedAs<Enum.ScaleType>?
		@field SliceCenter Fusion.UsedAs<Rect>?
		@field SliceScale Fusion.UsedAs<number>?
		@field TileSize Fusion.UsedAs<UDim2>?
]=]
return function(Props: Props)
	local FallbackImage =
		Util.EnsureValue(Props.FallbackImage, "string", "rbxasset://textures/ui/GuiImagePlaceholder.png")
	local Image = Util.EnsureValue(Props.Image, "string", nil)

	local ImageInUse = Computed(function()
		if Image:get() then
			return Image:get()
		else
			return FallbackImage:get()
		end
	end)

	return Hydrate(Base(Util.CombineProps(Props, {
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
		ScaleType = Props.ScaleType,
		SliceCenter = Props.SliceCenter,
		SliceScale = Props.SliceScale,
		TileSize = Props.TileSize,
	}
end
