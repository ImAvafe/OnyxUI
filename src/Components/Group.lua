--[=[
		@class Group
		
		Equivalent to Roblox's `CanvasGroup` instance.
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local Fusion = require(OnyxUI.Packages.Fusion)

local Base = require(script.Parent.Base)
local Components = {
	Base = Base,
}

export type Props = Base.Props & {
	GroupTransparency: Fusion.UsedAs<number>?,
	GroupColor3: Fusion.UsedAs<Color3>?,
}

--[=[
		@within Group
		@interface GroupProps

		@field ... BaseProps
		@field GroupTransparency Fusion.UsedAs<number>?
		@field GroupColor3 Fusion.UsedAs<Color3>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = Fusion.innerScope(Scope, Fusion, Util, Components)

	return Scope:Hydrate(Scope:Base(Util.CombineProps(Props, {
		ClassName = "CanvasGroup",
		Name = "Group",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))) {
		GroupTransparency = Props.GroupTransparency,
		GroupColor3 = Props.GroupColor3,
	}
end
