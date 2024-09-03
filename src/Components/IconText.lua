--[=[
		@class IconText
		
		For displaying both text and icons alongside each other as one seamless body.
]=]

local OnyxUI = require(script.Parent.Parent)
local Util = require(OnyxUI.Util)

local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed
local ForValues = Fusion.ForValues

local Frame = require(OnyxUI.Components.Frame)
local Text = require(OnyxUI.Components.Text)
local Icon = require(OnyxUI.Components.Icon)

export type Props = Frame.Props & {
	Content: Fusion.UsedAs<{ string }>?,
	ContentColor: Fusion.UsedAs<Color3>?,
	ContentSize: Fusion.UsedAs<number>?,
	ContentTransparency: Fusion.UsedAs<number>?,
	ContentWrapped: Fusion.UsedAs<boolean>?,
	ContentRichText: Fusion.UsedAs<boolean>?,
	ContentFontFace: Fusion.UsedAs<Font>?,
}

--[=[
		@within IconText
		@interface IconTextProps

		@field ... FrameProps
		@field Content Fusion.UsedAs<{ string }>?
		@field ContentColor Fusion.UsedAs<Color3>?
		@field ContentSize Fusion.UsedAs<number>?
		@field ContentTransparency Fusion.UsedAs<number>?
		@field ContentWrapped Fusion.UsedAs<boolean>?
		@field ContentRichText Fusion.UsedAs<boolean>?
		@field ContentFontFace Fusion.UsedAs<Font>?
]=]
return function(Props: Props)
	local Content = Util.EnsureValue(Props.Content, "table", {})
	local ContentSize = Util.EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1"])
	local ContentColor = Util.EnsureValue(Props.ContentColor, "Color3", Themer.Theme.Colors.BaseContent.Main)
	local ContentTransparency = Util.EnsureValue(Props.ContentTransparency, "number", 0)
	local ContentWrapped = Util.EnsureValue(Props.ContentWrapped, "boolean", true)
	local ContentRichText = Util.EnsureValue(Props.ContentRichText, "boolean", true)
	local ContentFontFace = Util.EnsureValue(
		Props.ContentFontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Body:get())
		end)
	)

	return Frame(Util.CombineProps(Props, {
		Name = script.Name,
		ListEnabled = true,
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListPadding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0"]:get())
		end),

		[Children] = {
			ForValues(Content, function(ContentString: string)
				if string.find(ContentString, "rbxassetid://", 1, true) then
					return Icon {
						Image = ContentString,
						ImageColor3 = ContentColor,
						Size = Computed(function()
							return UDim2.fromOffset(ContentSize:get(), ContentSize:get())
						end),
						ImageTransparency = ContentTransparency,
					}
				else
					return Text {
						Text = ContentString,
						TextColor3 = ContentColor,
						TextSize = ContentSize,
						TextTransparency = ContentTransparency,
						TextWrapped = ContentWrapped,
						RichText = ContentRichText,
						FontFace = ContentFontFace,
					}
				end
			end, Fusion.cleanup),
		},
	}))
end
