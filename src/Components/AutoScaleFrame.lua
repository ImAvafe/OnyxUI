local Workspace = game:GetService("Workspace")
local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local PubTypes = require(OnyxUI.Utils.PubTypes)

local Value = Fusion.Value
local Computed = Fusion.Computed
local Out = Fusion.Out
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)
local Frame = require(script.Parent.Frame)

export type Props = Base.Props & {
	BaseResolution: PubTypes.CanBeState<Vector2>?,
	MinScale: PubTypes.CanBeState<number>?,
	MaxScale: PubTypes.CanBeState<number>?,
	ScaleMultiplier: PubTypes.CanBeState<number>?,
}

return function(Props: Props)
	local BaseResolution = EnsureValue(Props.BaseResolution, "Vector2", Vector2.new())
	local MinScale = EnsureValue(Props.MinScale, "number", 0.8)
	local MaxScale = EnsureValue(Props.MaxScale, "number", math.huge)
	local ScaleMultiplier = EnsureValue(Props.ScaleMultiplier, "number", 1)

	local ViewportSize = Value(Vector2.new())
	Hydrate(Workspace.CurrentCamera) {
		[Out "ViewportSize"] = ViewportSize,
	}

	return Frame {
		Name = "AutoScaleFrame",
		Scale = Computed(function()
			local Ratio = ScaleMultiplier:get()
				/ math.max(
					(BaseResolution:get().X / ViewportSize:get().X),
					(BaseResolution:get().Y / ViewportSize:get().Y)
				)
			return math.clamp(Ratio, MinScale:get(), MaxScale:get())
		end),
	}
end
