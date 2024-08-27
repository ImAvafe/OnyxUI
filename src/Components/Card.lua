--[=[
		@class Card
		
		Useful for grouping and displaying Content in a user friendly way.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)

export type Props = Frame.Props & {}

--[=[
		@within Card
		@interface CardProps

		@field ... FrameProps
		@field ... CardProps
]=]
return function(Props: Props)
	return Frame(Util.CombineProps(Props, {
		Name = "Card",
		BackgroundColor3 = Themer.Theme.Colors.Neutral.Dark,
		BackgroundTransparency = 0,
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end),
		Padding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end),
	}))
end
