--[=[
		@class AutoScaleFrame
		
		Automatically scales children for the user's screen. 📱💻📺🥽
]=]

local Workspace = game:GetService("Workspace")

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Out = Fusion.Out

local Base = require(script.Parent.Base)
local Frame = require(script.Parent.Frame)
local Components = {
	Base = Base,
	Frame = Frame,
}

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
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local BaseResolution = Util.Fallback(Props.BaseResolution, Vector2.new())
	local MinScale = Util.Fallback(Props.MinScale, 0.8)
	local MaxScale = Util.Fallback(Props.MaxScale, math.huge)
	local ScaleMultiplier = Util.Fallback(Props.ScaleMultiplier, 1)

	local ViewportSize = Scope:Value(Vector2.new())
	Scope:Hydrate(Workspace.CurrentCamera) {
		[Out "ViewportSize"] = ViewportSize,
	}

	return Scope:Frame(Util.CombineProps(Props, {
		Name = "AutoScaleFrame",
		Scale = Scope:Computed(function(use)
			local Ratio = use(ScaleMultiplier)
				/ math.max((use(BaseResolution).X / use(ViewportSize).X), (use(BaseResolution).Y / use(ViewportSize).Y))
			return math.clamp(Ratio, use(MinScale), use(MaxScale))
		end),
	}))
end
