--[=[
		@class AutoScaleFrame
		
		Automatically scales children for the user's screen. 📱💻📺🥽
]=]

local Workspace = game:GetService("Workspace")

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)

local Out = Fusion.Out
local InnerScope = Fusion.innerScope

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
	local Scope = InnerScope(Scope, Fusion, Util, Components)

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
		Scale = Scope:Computed(function(Use)
			local Ratio = Use(ScaleMultiplier)
				/ math.max((Use(BaseResolution).X / Use(ViewportSize).X), (Use(BaseResolution).Y / Use(ViewportSize).Y))
			return math.clamp(Ratio, Use(MinScale), Use(MaxScale))
		end),
	}))
end
