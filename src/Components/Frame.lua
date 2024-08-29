--[=[
		@class Frame
		
		A barebones container object. Unlike Roblox's `Frame`, it is transparent by default.
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)

local Base = require(script.Parent.Base)

export type Props = Base.Props & {}

--[=[
		@within Frame
		@interface FrameProps

		@field ... BaseProps
]=]
return function(Props: Props)
	return Base(Util.CombineProps(Props, {
		ClassName = "Frame",
		Name = "Frame",
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
	}))
end
