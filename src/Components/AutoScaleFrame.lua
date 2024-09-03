--[=[
		@class AutoScaleFrame
		
		Automatically scales children for the user's screen. 📱💻📺🥽
]=]

local Workspace = game:GetService("Workspace")

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)

local Value = Fusion.Value
local Computed = Fusion.Computed
local Out = Fusion.Out
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)
local Frame = require(script.Parent.Frame)

export type Props = Base.Props & {
	BaseResolution: Fusion.UsedAs<Vector2>?,
	MinScale: Fusion.UsedAs<number>?,
	MaxScale: Fusion.UsedAs<number>?,
	ScaleMultiplier: Fusion.UsedAs<number>?,
}

--[=[
		@within AutoScaleFrame
		@interface AutoScaleFrameProps

		@field ... BaseProps
		@field BaseResolution Fusion.UsedAs<Vector2>?
		@field MinScale Fusion.UsedAs<number>?
		@field MaxScale Fusion.UsedAs<number>?
		@field ScaleMultiplier Fusion.UsedAs<number>?
]=]
return function(Props: Props)
	local BaseResolution = Util.EnsureValue(Props.BaseResolution, "Vector2", Vector2.new())
	local MinScale = Util.EnsureValue(Props.MinScale, "number", 0.8)
	local MaxScale = Util.EnsureValue(Props.MaxScale, "number", math.huge)
	local ScaleMultiplier = Util.EnsureValue(Props.ScaleMultiplier, "number", 1)

	local ViewportSize = Value(Vector2.new())
	Hydrate(Workspace.CurrentCamera) {
		[Out "ViewportSize"] = ViewportSize,
	}

	return Frame(Util.CombineProps(Props, {
		Name = "AutoScaleFrame",
		Scale = Computed(function()
			local Ratio = ScaleMultiplier:get()
				/ math.max(
					(BaseResolution:get().X / ViewportSize:get().X),
					(BaseResolution:get().Y / ViewportSize:get().Y)
				)
			return math.clamp(Ratio, MinScale:get(), MaxScale:get())
		end),
	}))
end
