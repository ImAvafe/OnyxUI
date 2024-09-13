--[=[
		@class Frame
		
		A barebones container object. Unlike Roblox's `Frame`, it is transparent by default.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)

local InnerScope = Fusion.innerScope

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
	local Scope = InnerScope(Scope, Fusion, Util, Components)

	return Scope:Base(Util.CombineProps(Props, {
		ClassName = "Frame",
		Name = "Frame",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))
end
