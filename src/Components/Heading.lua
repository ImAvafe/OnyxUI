--[=[
		@class Heading
		
		For sectioning bodies of text or content, like for a menu title.
]=]

local OnyxUI = require(script.Parent.Parent)
local Util = require(OnyxUI.Util)
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Computed = Fusion.Computed

local Text = require(OnyxUI.Components.Text)

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
