--[=[
		@class IconText
		
		For displaying both text and icons alongside each other as one seamless body.
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Text = require(OnyxUI.Components.Text)
local Icon = require(OnyxUI.Components.Icon)
local Components = {
	Text = Text,
	Icon = Icon,
	Frame = Frame,
}

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
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Content = Util.Fallback(Props.Content, {})
	local ContentSize = Util.Fallback(Props.ContentSize, Theme.TextSize["1"])
	local ContentColor = Util.Fallback(Props.ContentColor, Theme.Colors.BaseContent.Main)
	local ContentTransparency = Util.Fallback(Props.ContentTransparency, 0)
	local ContentWrapped = Util.Fallback(Props.ContentWrapped, true)
	local ContentRichText = Util.Fallback(Props.ContentRichText, true)
	local ContentFontFace = Util.Fallback(
		Props.ContentFontFace,
		Scope:Computed(function(Use)
			return Font.new(Use(Theme.Font.Body), Use(Theme.FontWeight.Body))
		end)
	)

	return Scope:Frame(Util.CombineProps(Props, {
		Name = script.Name,
		ListEnabled = true,
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListPadding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["0"]))
		end),

		[Children] = {
			Scope:ForValues(Content, function(Use, Scope, ContentString: string)
				if string.find(ContentString, "rbxassetid://", 1, true) then
					return Scope:Icon {
						Image = ContentString,
						ImageColor3 = ContentColor,
						Size = Scope:Computed(function(Use)
							return UDim2.fromOffset(Use(ContentSize), Use(ContentSize))
						end),
						ImageTransparency = ContentTransparency,
					}
				else
					return Scope:Text {
						Text = ContentString,
						TextColor3 = ContentColor,
						TextSize = ContentSize,
						TextTransparency = ContentTransparency,
						TextWrapped = ContentWrapped,
						RichText = ContentRichText,
						FontFace = ContentFontFace,
					}
				end
			end),
		},
	}))
end
