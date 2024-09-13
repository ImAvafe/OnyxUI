--[=[
		@class Icon
		
		It's an icon, what else do I say? 💀💀
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(script.Parent.Parent.Themer)

local InnerScope = Fusion.innerScope

local Image = require(script.Parent.Image)
local Components = {
	Image = Image,
}

export type Props = Image.Props & {}

--[=[
		@within Icon
		@interface IconProps

		@field ... ImageProps
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	return Scope:Image(Util.CombineProps(Props, {
		Name = "Icon",
		Size = Scope:Computed(function(Use)
			return UDim2.fromOffset(Use(Theme.TextSize["1"]), Use(Theme.TextSize["1"]))
		end),
		BackgroundTransparency = 1,
	}))
end
