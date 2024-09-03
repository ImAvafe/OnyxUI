--[=[
		@class Group
		
		Equivalent to Roblox's `CanvasGroup` instance.
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local PubTypes = require(OnyxUI.Util.PubTypes)
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)

local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	GroupTransparency: PubTypes.CanBeState<number>?,
	GroupColor3: PubTypes.CanBeState<Color3>?,
}

--[=[
		@within Group
		@interface GroupProps

		@field ... BaseProps
		@field GroupTransparency CanBeState<number>?
		@field GroupColor3 CanBeState<Color3>?
]=]
return function(Props: Props)
	return Hydrate(Base(Util.CombineProps(Props, {
		ClassName = "CanvasGroup",
		Name = "Group",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))) {
		GroupTransparency = Props.GroupTransparency,
		GroupColor3 = Props.GroupColor3,
	}
end
