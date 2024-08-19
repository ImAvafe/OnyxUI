local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Themer)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Children = Fusion.Children
local Computed = Fusion.Computed
local ForValues = Fusion.ForValues

local Frame = require(script.Parent.Frame)
local Text = require(script.Parent.Text)
local Icon = require(script.Parent.Icon)

export type Props = Frame.Props & {
	Contents: PubTypes.CanBeState<{ string }>?,
	ContentsWrapped: PubTypes.CanBeState<boolean>?,
	Color: PubTypes.CanBeState<Color3>?,
	ContentColor: PubTypes.CanBeState<Color3>?,
	ContentSize: PubTypes.CanBeState<number>?,
}

return function(Props: Props)
	local Contents = EnsureValue(Props.Contents, "table", {})
	local ContentWraps = EnsureValue(Props.ContentsWrapped, "boolean", true)
	local Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Base.Main)
	local ContentColor = EnsureValue(
		Props.ContentColor,
		"Color3",
		Computed(function()
			return ColorUtils.Emphasize(Color:get(), Themer.Theme.Emphasis.Contrast:get())
		end)
	)
	local ContentSize = EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1"])

	return Frame(CombineProps(Props, {
		Name = "Badge",
		BackgroundColor3 = Color,
		BackgroundTransparency = 0,
		Padding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0"]:get())
		end),
		PaddingLeft = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end),
		PaddingRight = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end),
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["2"]:get())
		end),
		ListEnabled = true,
		ListPadding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end),
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
		ListWrapsVerticalAlignment = Enum.VerticalAlignment.Center,
		ListWraps = ContentWraps,

		[Children] = {
			ForValues(Contents, function(ContentString: string)
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
						FontFace = Computed(function()
							return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Bold:get())
						end),
						TextWrapped = ContentWraps,
					}
				end
			end, Fusion.cleanup),
		},
	}))
end
