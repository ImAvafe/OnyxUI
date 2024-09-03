--[=[
		@class Image
		
		Equivalent to Roblox's `ImageLabel`.
]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)
local PubTypes = require(OnyxUI.Util.PubTypes)

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

--[=[
		@within Image
		@interface ImageProps

		@field ... BaseProps
		@field Image CanBeState<string>?
		@field FallbackImage CanBeState<string>?
		@field ImageColor3 CanBeState<Color3>?
		@field ImageTransparency CanBeState<number>?
		@field ImageRectSize CanBeState<Vector2>?
		@field ResampleMode CanBeState<Enum.ResamplerMode>?
		@field ScaleType CanBeState<Enum.ScaleType>?
		@field SliceCenter CanBeState<Rect>?
		@field SliceScale CanBeState<number>?
		@field TileSize CanBeState<UDim2>?
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
