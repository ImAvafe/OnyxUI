local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local ForValues = Fusion.ForValues
local Computed = Fusion.Computed

local BaseButton = require(OnyxUI.Components.BaseButton)
local Text = require(OnyxUI.Components.Text)
local Icon = require(OnyxUI.Components.Icon)

local function Button(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Button")

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
	Props.ContentSize = EnsureValue(
		Props.ContentSize,
		"number",
		Computed(function()
			return Themer.Theme.TextSize:get() * 1.1
		end)
	)

	Props.IsHolding = EnsureValue(Props.IsHolding, "boolean", false)

	local BackgroundColor = Computed(function()
		if Props.IsHolding:get() then
			return ColourUtils.Darken(Props.Color:get(), 0.1)
		else
			return Props.Color:get()
		end
	end)
	local ContentColor = Computed(function()
		if Props.Style:get() == "Filled" then
			return Props.ContrastColor:get()
		else
			return Props.Color:get()
		end
	end)

	return Finalize(BaseButton {
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

		BackgroundTransparency = Computed(function()
			if Props.Style:get() == "Filled" then
				return 0
			else
				if Props.IsHolding:get() then
					return 0.9
				else
					return 1
				end
			end
		end),
		BackgroundColor3 = BackgroundColor,

		IsHovering = Props.IsHovering,

		OnActivated = Props.OnActivated,
		OnMouseButton1Down = function()
			Props.IsHolding:set(true)
		end,
		OnMouseButton1Up = function()
			Props.IsHolding:set(false)
		end,
		OnMouseLeave = function()
			Props.IsHolding:set(false)
		end,

		[Children] = {
			New "UICorner" {
				CornerRadius = Computed(function()
					return UDim.new(0, Themer.Theme.CornerRadius:get() / 1.5)
				end),
			},
			New "UIPadding" {
				PaddingBottom = Computed(function()
					return UDim.new(0, Themer.Theme.Space:get())
				end),
				PaddingLeft = Computed(function()
					return UDim.new(0, Themer.Theme.Space:get() * 3)
				end),
				PaddingRight = Computed(function()
					return UDim.new(0, Themer.Theme.Space:get() * 3)
				end),
				PaddingTop = Computed(function()
					return UDim.new(0, Themer.Theme.Space:get())
				end),
			},
			New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = Computed(function()
					return UDim.new(0, Themer.Theme.Space:get())
				end),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = BackgroundColor,
				Thickness = Themer.Theme.StrokeThickness,
			},

			ForValues(Props.Contents, function(ContentString: string)
				if string.find(ContentString, "rbxassetid://", 1, true) then
					return Icon {
						Image = ContentString,
						ImageColor3 = ContentColor,
						Size = Computed(function()
							return UDim2.fromOffset(Props.ContentSize:get(), Props.ContentSize:get())
						end),
					}
				else
					return Text {
						Text = ContentString,
						TextColor3 = ContentColor,
						TextSize = Props.ContentSize,
					}
				end
			end, Fusion.Cleanup),
		},
	})
end

return Button
