--[=[
		@class Image
		
		Equivalent to Roblox's `ImageLabel`.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)

local Base = require(script.Parent.Base)
local Components = {
	Base = Base,
}

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
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)

	local FallbackImage = Util.Fallback(Props.FallbackImage, "rbxasset://textures/ui/GuiImagePlaceholder.png")
	local Image = Util.Fallback(Props.Image, nil)

	local ImageInUse = Scope:Computed(function(Use)
		if Use(Image) then
			return Use(Image)
		else
			return Use(FallbackImage)
		end
	end)

	return Scope:Hydrate(Scope:Base(Util.CombineProps(Props, {
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
