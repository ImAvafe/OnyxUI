--[=[
		@class Heading
		
		For sectioning bodies of text or content, like for a menu title.
]=]

local OnyxUI = require(script.Parent.Parent)
local Util = require(OnyxUI.Util)
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Computed = Fusion.Computed

local Text = require(OnyxUI.Components.Text)

export type Props = Text.Props & {
	HeadingSize: PubTypes.CanBeState<number>?,
	TextSize: PubTypes.CanBeState<number>?,
}

--[=[
		@within Heading
		@interface HeadingProps

		@field ... TextProps
		@field HeadingSize CanBeState<number>?
		@field TextSize CanBeState<number>?
]=]
return function(Props: Props)
	local HeadingSize = Util.EnsureValue(Props.HeadingSize, "number", 1.75)
	local TextSize = Util.EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])

	return Text(Util.CombineProps(Props, {
		Name = script.Name,
		TextSize = Computed(function()
			local HeadingSizeValue = HeadingSize:get()
			local TextSizeValue = TextSize:get()

			return TextSizeValue * HeadingSizeValue
		end),
		FontFace = Computed(function()
			return Font.new(Themer.Theme.Font.Heading:get(), Themer.Theme.FontWeight.Heading:get())
		end),
	}))
end
