--[=[
		@class Heading
		
		For sectioning bodies of text or content, like for a menu title.
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local InnerScope = Fusion.innerScope

local Text = require(OnyxUI.Components.Text)
local Components = {
	Text = Text,
}

export type Props = Text.Props & {
	HeadingSize: Fusion.UsedAs<number>?,
	TextSize: Fusion.UsedAs<number>?,
}

--[=[
		@within Heading
		@interface HeadingProps

		@field ... TextProps
		@field HeadingSize Fusion.UsedAs<number>?
		@field TextSize Fusion.UsedAs<number>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local HeadingSize = Util.Fallback(Props.HeadingSize, 1.75)
	local TextSize = Util.Fallback(Props.TextSize, Theme.TextSize["1"])

	return Scope:Text(Util.CombineProps(Props, {
		Name = script.Name,
		TextSize = Scope:Computed(function(Use)
			local HeadingSizeValue = Use(HeadingSize)
			local TextSizeValue = Use(TextSize)

			return TextSizeValue * HeadingSizeValue
		end),
		FontFace = Scope:Computed(function(Use)
			return Font.new(Use(Theme.Font.Heading), Use(Theme.FontWeight.Heading))
		end),
	}))
end
