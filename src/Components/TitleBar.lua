--[=[
		@class TitleBar
		
		For displaying a title, and an optional close button. Pairs with [`MenuFrame`](/api/MenuFrame).
]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)
local IconButton = require(script.Parent.IconButton)
local IconText = require(script.Parent.IconText)

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
return function(Props: Props)
	local Content = Util.EnsureValue(Props.Content, "table", {})
	local ContentSize = Util.EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1.5"])
	local ContentColor = Util.EnsureValue(Props.ContentColor, "Color3", Themer.Theme.Colors.BaseContent.Main)
	local ContentFontFace = Util.EnsureValue(
		Props.ContentFontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Heading:get(), Themer.Theme.FontWeight.Heading:get())
		end)
	)
	local CloseButtonDisabled = Util.EnsureValue(Props.CloseButtonDisabled, "boolean", false)
	local CloseButtonIcon = Util.EnsureValue(Props.CloseButtonIcon, "string", "rbxassetid://80218226919142")
	local OnClose = Util.EnsureValue(Props.OnClose, "function", function() end)

	return Frame(Util.CombineProps(Props, {
		Name = "TitleBar",
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,

		[Children] = {
			IconText {
				Name = "Title",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),
				Content = Content,
				ContentColor = ContentColor,
				ContentSize = ContentSize,
				ContentFontFace = ContentFontFace,
				ContentWrapped = false,
				ListPadding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
				end),
			},
			Computed(function()
				if CloseButtonDisabled:get() == false then
					return IconButton {
						Name = "CloseButton",
						Image = CloseButtonIcon,
						ContentSize = ContentSize,
						ContentColor = ContentColor,
						Color = ContentColor,
						Style = "Ghost",
						AnchorPoint = Vector2.new(1, 0.5),
						Position = UDim2.fromScale(1, 0.5),

						OnActivated = function()
							if OnClose:get() then
								OnClose:get()()
							end
						end,
					}
				else
					return
				end
			end, Fusion.cleanup),
		},
	}))
end
