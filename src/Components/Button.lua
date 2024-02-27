local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Value = Fusion.Value
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
	Props.BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Contrast)
	Props.ContentSize = EnsureValue(Props.ContentSize, "number", Themer.Theme.TextSize:get() * 1.1)

	local IsHolding = Value(false)
	local ContentColor3 = Computed(function()
		if Props.Color:get() ~= nil then
			return Props.Color:get()
		end
		if Props.Style:get() == "Filled" then
			return Color3.fromRGB(0, 0, 0)
		else
			return Color3.fromRGB(255, 255, 255)
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
				return 1
			end
		end),
		BackgroundColor3 = Computed(function()
			if IsHolding:get() then
				return ColourUtils.Darken(Props.BackgroundColor3:get(), 0.08)
			else
				return Props.BackgroundColor3:get()
			end
		end),

		OnActivated = Props.OnActivated,
		IsHovering = Props.IsHovering,

		OnMouseButton1Down = function()
			IsHolding:set(true)
		end,
		OnMouseButton1Up = function()
			IsHolding:set(false)
		end,
		OnMouseLeave = function()
			IsHolding:set(false)
		end,

		[Children] = {
			New "UICorner" {
				CornerRadius = Computed(function()
					return UDim.new(0, Themer.Theme.CornerRadius:get() / 1.5)
				end),
			},
			New "UIPadding" {
				PaddingBottom = UDim.new(0, Themer.Theme.Space:get() * 1),
				PaddingLeft = UDim.new(0, Themer.Theme.Space:get() * 3),
				PaddingRight = UDim.new(0, Themer.Theme.Space:get() * 3),
				PaddingTop = UDim.new(0, Themer.Theme.Space:get() * 1),
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
				Color = Computed(function()
					if Props.Style:get() == "Filled" then
						return Props.BackgroundColor3:get()
					else
						return ColourUtils.Darken(Props.BackgroundColor3:get(), 0.35)
					end
				end),
				Thickness = Themer.Theme.StrokeThickness,
			},

			ForValues(Props.Contents, function(ContentString)
				if string.find(ContentString, "rbxassetid://", 1, true) then
					return Icon {
						Image = ContentString,
						ImageColor3 = ContentColor3,
						Size = Computed(function()
							local BaseSize = Props.ContentSize:get()
							return UDim2.fromOffset(BaseSize, BaseSize)
						end),
					}
				else
					return Text {
						Text = ContentString,
						TextColor3 = ContentColor3,
						TextSize = Props.ContentSize,
						ClipsDescendants = false,
					}
				end
			end, Fusion.Cleanup),
		},
	})
end

return Button
