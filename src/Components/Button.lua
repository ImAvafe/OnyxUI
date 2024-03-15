local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)

local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local ForValues = Fusion.ForValues
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local BaseButton = require(OnyxUI.Components.BaseButton)
local Text = require(OnyxUI.Components.Text)
local Icon = require(OnyxUI.Components.Icon)

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925
local DISABLED_CONTENT_TRANSPARENCY = 0.75
local HOLDING_BACKGROUND_TRANSPARENCY = 0.95

local function Button(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Button")
	Props.ClipsDescendants = EnsureValue(Props.ClipsDescendants, "boolean", true)

	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)
	Props.Contents = EnsureValue(Props.Contents, "table", {})
	Props.Style = EnsureValue(Props.Style, "string", "Filled")
	Props.Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.ContrastColor = EnsureValue(
		Props.ContrastColor,
		"Color3",
		Computed(function()
			return ColourUtils.Emphasise(Props.Color:get(), 1)
		end)
	)
	Props.ContentSize = EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize["1"])
	Props.Padding = EnsureValue(
		Props.Padding,
		"UIPadding",
		New "UIPadding" {
			PaddingBottom = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
			end),
			PaddingLeft = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
			end),
			PaddingRight = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
			end),
			PaddingTop = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
			end),
		}
	)

	Props.IsHolding = EnsureValue(Props.IsHolding, "boolean", false)

	local Color = Computed(function()
		if Props.Disabled:get() then
			return Themer.Theme.Colors.BaseContent.Main:get()
		else
			if Props.IsHolding:get() then
				return ColourUtils.Emphasise(Props.Color:get(), Themer.Theme.Emphasis:get())
			else
				return Props.Color:get()
			end
		end
	end)
	local ContentColor = Computed(function()
		if Props.Disabled:get() then
			return Themer.Theme.Colors.BaseContent.Main:get()
		else
			if Props.Style:get() == "Filled" then
				return Props.ContrastColor:get()
			elseif Props.Style:get() == "Outlined" then
				return Color:get()
			elseif Props.Style:get() == "Ghost" then
				return Color:get()
			end
		end
	end)
	local ContentTransparency = Computed(function()
		if Props.Disabled:get() then
			return DISABLED_CONTENT_TRANSPARENCY
		else
			return 0
		end
	end)

	return BaseButton {
		Name = Props.Name,
		Parent = Props.Parent,
		Position = Props.Position,
		Rotation = Props.Rotation,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		Visible = Props.Visible,
		ZIndex = Props.ZIndex,
		LayoutOrder = Props.LayoutOrder,
		ClipsDescendants = Props.ClipsDescendants,
		Active = Props.Active,
		Selectable = Props.Selectable,
		Interactable = Props.Interactable,

		BackgroundTransparency = Computed(function()
			if Props.Style:get() == "Filled" then
				if Props.Disabled:get() then
					return DISABLED_BACKGROUND_TRANSPARENCY
				else
					return 0
				end
			else
				if Props.IsHolding:get() then
					return HOLDING_BACKGROUND_TRANSPARENCY
				else
					return 1
				end
			end
		end),
		BackgroundColor3 = Spring(Color, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening),

		IsHovering = Props.IsHovering,
		IsHolding = Props.IsHolding,
		OnActivated = Props.OnActivated,

		Disabled = Props.Disabled,

		[Children] = {
			New "UICorner" {
				CornerRadius = Computed(function()
					return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
				end),
			},
			Props.Padding,
			New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
				end),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Spring(Color, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening),
				Thickness = Themer.Theme.StrokeThickness["1"],
				Transparency = Computed(function()
					if Props.Style:get() == "Ghost" then
						return 1
					elseif Props.Disabled:get() then
						return DISABLED_BACKGROUND_TRANSPARENCY
					else
						return 0
					end
				end),
			},

			ForValues(Props.Contents, function(ContentString: string)
				if string.find(ContentString, "rbxassetid://", 1, true) then
					return Icon {
						Image = ContentString,
						ImageColor3 = ContentColor,
						Size = Computed(function()
							return UDim2.fromOffset(Props.ContentSize:get(), Props.ContentSize:get())
						end),
						ImageTransparency = ContentTransparency,
					}
				else
					return Text {
						Text = ContentString,
						TextColor3 = ContentColor,
						TextSize = Props.ContentSize,
						TextTransparency = ContentTransparency,
					}
				end
			end, Fusion.cleanup),
		},
	}
end

return Button
