--[=[
		@class TitleBar
		
		For displaying a title, and an optional close button. Pairs with [`MenuFrame`](/api/MenuFrame).
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local InnerScope = Fusion.innerScope

local Frame = require(script.Parent.Frame)
local IconButton = require(script.Parent.IconButton)
local IconText = require(script.Parent.IconText)
local Components = {
	Frame = Frame,
	IconButton = IconButton,
	IconText = IconText,
}

export type Props = Frame.Props & {
	Content: Fusion.UsedAs<{ string }>?,
	ContentSize: Fusion.UsedAs<number>?,
	ContentColor: Fusion.UsedAs<Color3>?,
	ContentFontFace: Fusion.UsedAs<Font>?,
	CloseButtonIcon: Fusion.UsedAs<string>?,
	CloseButtonDisabled: Fusion.UsedAs<boolean>?,
	OnClose: Fusion.UsedAs<() -> ()>?,
}

--[=[
		@within TitleBar
		@interface TitleBarProps

		@field ... FrameProps
		@field Content Fusion.UsedAs<{ string }>?
		@field ContentSize Fusion.UsedAs<number>?
		@field ContentColor Fusion.UsedAs<Color3>?
		@field ContentFontFace Fusion.UsedAs<Font>?
		@field CloseButtonIcon Fusion.UsedAs<string>?
		@field CloseButtonDisabled Fusion.UsedAs<boolean>?
		@field OnClose Fusion.UsedAs<() -> ()>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Content = Util.Fallback(Props.Content, {})
	local ContentSize = Util.Fallback(Props.ContentSize, Theme.TextSize["1.5"])
	local ContentColor = Util.Fallback(Props.ContentColor, Theme.Colors.BaseContent.Main)
	local ContentFontFace = Util.Fallback(
		Props.ContentFontFace,
		Scope:Computed(function(Use)
			return Font.new(Use(Theme.Font.Heading), Use(Theme.FontWeight.Heading))
		end)
	)
	local CloseButtonDisabled = Util.Fallback(Props.CloseButtonDisabled, false)
	local CloseButtonIcon = Util.Fallback(Props.CloseButtonIcon, "rbxassetid://80218226919142")
	local OnClose = Util.Fallback(Props.OnClose, function() end)

	return Scope:Frame(Util.CombineProps(Props, {
		Name = "TitleBar",
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,

		[Children] = {
			Scope:IconText {
				Name = "Title",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),
				Content = Content,
				ContentColor = ContentColor,
				ContentSize = ContentSize,
				ContentFontFace = ContentFontFace,
				ContentWrapped = false,
				ListPadding = Scope:Computed(function(Use)
					return UDim.new(0, Use(Theme.Spacing["0.5"]))
				end),
			},
			Scope:Computed(function(Use)
				if Use(CloseButtonDisabled) == false then
					return Scope:IconButton {
						Name = "CloseButton",
						Image = CloseButtonIcon,
						ContentSize = ContentSize,
						ContentColor = ContentColor,
						Color = ContentColor,
						Style = "Ghost",
						AnchorPoint = Vector2.new(1, 0.5),
						Position = UDim2.fromScale(1, 0.5),

						OnActivated = function()
							if Use(OnClose) then
								Use(OnClose)()
							end
						end,
					}
				else
					return
				end
			end),
		},
	}))
end
