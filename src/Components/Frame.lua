--[=[
		@class Frame
		
		A barebones container object. Unlike Roblox's `Frame`, it is transparent by default.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)

local Base = require(script.Parent.Base)
local Components = {
	Base = Base,
}

export type Props = Base.Props & {}

--[=[
		@within Frame
		@interface FrameProps

		@field ... BaseProps
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)

	return Scope:Base(Util.CombineProps(Props, {
		ClassName = "Frame",
		Name = "Frame",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))
end
