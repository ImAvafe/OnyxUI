--[=[
		@class Icon
		
		It's an icon, what else do I say? 💀💀
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(script.Parent.Parent.Themer)

local Image = require(script.Parent.Image)
local Components = {}

export type Props = Image.Props & {}

--[=[
		@within Icon
		@interface IconProps

		@field ... ImageProps
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	return Image(Util.CombineProps(Props, {
		Name = "Icon",
		Size = Scope:Computed(function(use)
			return UDim2.fromOffset(use(Theme.TextSize["1"]), use(Theme.TextSize["1"]))
		end),
		BackgroundTransparency = 1,
	}))
end
