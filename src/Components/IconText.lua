local OnyxUI = require(script.Parent.Parent)
local Util = require(OnyxUI.Util)
local PubTypes = require(OnyxUI.Util.PubTypes)
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed
local ForValues = Fusion.ForValues

local Frame = require(OnyxUI.Components.Frame)
local Text = require(OnyxUI.Components.Text)
local Icon = require(OnyxUI.Components.Icon)

export type Props = Frame.Props & {
	Content: PubTypes.CanBeState<{ string }>?,
	ContentColor: PubTypes.CanBeState<Color3>?,
	ContentSize: PubTypes.CanBeState<number>?,
	ContentTransparency: PubTypes.CanBeState<number>?,
	ContentWrapped: PubTypes.CanBeState<boolean>?,
	ContentRichText: PubTypes.CanBeState<boolean>?,
	ContentFontFace: PubTypes.CanBeState<Font>?,
}

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
