--[=[
		@class TitleBar
		
		For displaying a title, and an optional close button. Pairs with [`MenuFrame`](/api/MenuFrame).
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Children = Fusion.Children
local Computed = Fusion.Computed
local ForValues = Fusion.ForValues

local Frame = require(script.Parent.Frame)
local Text = require(script.Parent.Text)
local IconButton = require(script.Parent.IconButton)
local Icon = require(script.Parent.Icon)

export type Props = Frame.Props & {
	Content: PubTypes.CanBeState<{ string }>?,
	ContentSize: PubTypes.CanBeState<number>?,
	ContentColor: PubTypes.CanBeState<Color3>?,
	ContentFontFace: PubTypes.CanBeState<Font>?,
	CloseButtonIcon: PubTypes.CanBeState<string>?,
	CloseButtonDisabled: PubTypes.CanBeState<boolean>?,
	OnClose: PubTypes.CanBeState<() -> ()>?,
	AutoLocalize: PubTypes.CanBeState<boolean>?,
}

--[=[
		@within TitleBar
		@interface TitleBarProps

		@field ... FrameProps
		@field ... TitleBarProps
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
			Frame {
				Name = "Content",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),
				ListEnabled = true,
				ListFillDirection = Enum.FillDirection.Horizontal,
				ListPadding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
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
							}
						else
							return Text {
								Text = ContentString,
								TextColor3 = ContentColor,
								TextSize = ContentSize,
								FontFace = ContentFontFace,
								TextWrapped = false,
								AutoLocalize = Props.AutoLocalize,
							}
						end
					end, Fusion.cleanup),
				},
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
