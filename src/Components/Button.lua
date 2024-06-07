local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local ColorUtils = require(OnyxUI.Packages.ColorUtils)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local PubTypes = require(script.Parent.Parent.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Children = Fusion.Children
local ForValues = Fusion.ForValues
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local BaseButton = require(script.Parent.BaseButton)
local Text = require(script.Parent.Text)
local Icon = require(script.Parent.Icon)

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925
local DISABLED_CONTENT_TRANSPARENCY = 0.75
local HOLDING_BACKGROUND_TRANSPARENCY = 0.95

export type Props = BaseButton.Props & {
	Disabled: PubTypes.CanBeState<boolean>?,
	Contents: PubTypes.CanBeState<{ string }>?,
	Style: PubTypes.CanBeState<string>?,
	Color: PubTypes.CanBeState<Color3>?,
	ContrastColor: PubTypes.CanBeState<Color3>?,
	ContentSize: PubTypes.CanBeState<number>?,
	IsHolding: PubTypes.CanBeState<boolean>?,
}

local function Button(Props: Props)
	local Disabled = EnsureValue(Props.Disabled, "boolean", false)
	local Contents = EnsureValue(Props.Contents, "table", {})
	local Style = EnsureValue(Props.Style, "string", "Filled")
	local Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local ContrastColor = EnsureValue(
		Props.ContrastColor,
		"Color3",
		Computed(function()
			return ColorUtils.Emphasize(Color:get(), 1)
		end)
	)
	local ContentSize = EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1"])
	local IsHolding = EnsureValue(Props.IsHolding, "boolean", false)

	local BackgroundColor3 = Computed(function()
		if Disabled:get() then
			return Themer.Theme.Colors.BaseContent.Main:get()
		else
			if IsHolding:get() then
				return ColorUtils.Emphasize(Color:get(), Themer.Theme.Emphasis:get())
			else
				return Color:get()
			end
		end
	end)
	local ContentColor = Computed(function()
		if Disabled:get() then
			return Themer.Theme.Colors.BaseContent.Main:get()
		else
			if Style:get() == "Filled" then
				return ContrastColor:get()
			elseif Style:get() == "Outlined" then
				return BackgroundColor3:get()
			elseif Style:get() == "Ghost" then
				return BackgroundColor3:get()
			else
				return ContrastColor:get()
			end
		end
	end)
	local ContentTransparency = Computed(function()
		if Disabled:get() then
			return DISABLED_CONTENT_TRANSPARENCY
		else
			return 0
		end
	end)

	return BaseButton(CombineProps(Props, {
		Name = "Button",
		BackgroundTransparency = Computed(function()
			if Style:get() == "Filled" then
				if Disabled:get() then
					return DISABLED_BACKGROUND_TRANSPARENCY
				else
					return 0
				end
			else
				if (not Disabled:get()) and IsHolding:get() then
					return HOLDING_BACKGROUND_TRANSPARENCY
				else
					return 1
				end
			end
		end),
		BackgroundColor3 = Spring(BackgroundColor3, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening),
		PaddingLeft = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
		end),
		PaddingRight = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
		end),
		PaddingTop = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end),
		PaddingBottom = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end),
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end),
		ListEnabled = true,
		ListPadding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
		end),
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
		ListVerticalAlignment = Enum.VerticalAlignment.Center,
		StrokeEnabled = true,
		StrokeColor = Spring(BackgroundColor3, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening),
		StrokeTransparency = Computed(function()
			if Style:get() == "Ghost" then
				return 1
			elseif Disabled:get() then
				return DISABLED_BACKGROUND_TRANSPARENCY
			else
				return 0
			end
		end),
		IsHolding = IsHolding,

		[Children] = {
			ForValues(Contents, function(ContentString: string)
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
						TextWrapped = false,
					}
				end
			end, Fusion.cleanup),
		},
	}))
end

return Button
