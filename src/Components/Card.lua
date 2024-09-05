--[=[
		@class Card
		
		Useful for grouping and displaying Content in a user friendly way.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Frame = require(script.Parent.Frame)
local Components = {
	Frame = Frame,
}

export type Props = Frame.Props & {}

--[=[
		@within Card
		@interface CardProps

		@field ... FrameProps
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	return Scope:Frame(Util.CombineProps(Props, {
		Name = "Card",
		BackgroundColor3 = Theme.Colors.Neutral.Main,
		BackgroundTransparency = 0,
		CornerRadius = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.CornerRadius["1"]))
		end),
		Padding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["1"]))
		end),
	}))
end
