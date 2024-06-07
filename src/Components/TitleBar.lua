local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local PubTypes = require(script.Parent.Parent.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Children = Fusion.Children
local Computed = Fusion.Computed
local ForValues = Fusion.ForValues

local Frame = require(script.Parent.Frame)
local Text = require(script.Parent.Text)
local IconButton = require(script.Parent.IconButton)
local Icon = require(script.Parent.Icon)

export type Props = Frame.Props & {
	Content: PubTypes.CanBeState<{string}>?,
	ContentSize: PubTypes.CanBeState<number>?,
	ContentColor: PubTypes.CanBeState<Color3>?,
	ContentFontFace: PubTypes.CanBeState<Font>?,
	CloseButtonIcon: PubTypes.CanBeState<string>?,
	CloseButtonDisabled: PubTypes.CanBeState<boolean>?,
	OnClose: PubTypes.CanBeState<() -> ()>?,
	AutoLocalize: PubTypes.CanBeState<boolean>?,
}

return function(Props: Props)
	local Content = EnsureValue(Props.Content, "table", {})
	local ContentSize = EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1.5"])
	local ContentColor = EnsureValue(Props.ContentColor, "Color3", Themer.Theme.Colors.BaseContent.Main)
	local ContentFontFace = EnsureValue(
		Props.ContentFontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Heading:get(), Themer.Theme.FontWeight.Heading:get())
		end)
	)
	local CloseButtonDisabled = EnsureValue(Props.CloseButtonDisabled, "boolean", false)
	local CloseButtonIcon = EnsureValue(Props.CloseButtonIcon, "string", "rbxassetid://13405228418")
	local OnClose = EnsureValue(Props.OnClose, "function", function() end)

	return Frame(CombineProps(Props, {
		Name = "TitleBar",
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,

		[Children] = {
			Frame {
				Name = "Content",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),

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
				}
			},
			Computed(function()
				if CloseButtonDisabled:get() == false then
					return IconButton {
						Name = "CloseButton",
						Image = CloseButtonIcon,
						ContentSize = ContentSize,
						ContentColor = ContentColor,
						Style = "Ghost",
						AnchorPoint = Vector2.new(1, 0),
						Position = UDim2.fromScale(1, 0),
						OnActivated = function()
							if OnClose:get() then
								OnClose:get()()
							end
						end,
					}
				end
			end, Fusion.cleanup),
		},
	}))
end