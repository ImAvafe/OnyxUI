local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureProp = require(OnyxUI.Utils.EnsureProp)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children
local ForValues = Fusion.ForValues
local Computed = Fusion.Computed

local BaseButton = require(OnyxUI.Components.BaseButton)
local Text = require(OnyxUI.Components.Text)
local Icon = require(OnyxUI.Components.Icon)

local function Button(Props)
	Props.Contents = EnsureProp(Props.Contents, "table", {})
	Props.Style = EnsureProp(Props.Style, "string", "Empty")
	Props.BackgroundColor3 = EnsureProp(Props.BackgroundColor3, "Color3", nil)
	Props.ContentColor3 = EnsureProp(Props.ContentColor3, "Color3", nil)
	Props.ContentSize = EnsureProp(Props.ContentSize, "number", 20)

	local IsHolding = Value(false)
	local ContentColor3 = Computed(function()
		if Props.ContentColor3:get() ~= nil then
			return Props.ContentColor3:get()
		end
		if Props.Style:get() == "Filled" then
			return Color3.fromRGB(0, 0, 0)
		else
			return Color3.fromRGB(255, 255, 255)
		end
	end)

	return Finalize(BaseButton {
		Name = Props.Name or "Button",
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		ZIndex = Props.ZIndex,

		BackgroundTransparency = Computed(function()
			if Props.Style:get() == "Filled" then
				return 0
			else
				if IsHolding:get() then
					return 0.95
				else
					return 1
				end
			end
		end),
		BackgroundColor3 = Computed(function()
			local BaseColor = Props.BackgroundColor3:get() or Color3.fromRGB(255, 255, 255)
			if IsHolding:get() then
				return ColourUtils.Darken(BaseColor, 0.08)
			else
				return BaseColor
			end
		end),
		ClipsDescendants = true,

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
				CornerRadius = UDim.new(0, 8),
			},
			New "UIPadding" {
				PaddingBottom = UDim.new(0, 6),
				PaddingLeft = UDim.new(0, 20),
				PaddingRight = UDim.new(0, 20),
				PaddingTop = UDim.new(0, 6),
			},
			New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 4),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				-- Enabled = Computed(function()
				--   return Props.Style:get() ~= "Filled"
				-- end),
				Color = Computed(function()
					local BaseColor = Props.BackgroundColor3:get() or Color3.fromRGB(255, 255, 255)
					if Props.Style:get() == "Filled" then
						return BaseColor
					else
						return ColourUtils.Darken(BaseColor, 0.35)
					end
				end),
				Thickness = 2,
			},

			ForValues(Props.Contents, function(ContentString)
				if string.find(ContentString, "rbxassetid://", 1, true) then
					return Icon {
						Image = ContentString,
						ImageColor3 = ContentColor3,
						Size = Computed(function()
							local BaseSize = Props.ContentSize:get() - 1
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
