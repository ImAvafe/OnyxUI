local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureProp = require(OnyxUI.Utils.EnsureProp)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local BaseButton = require(OnyxUI.Components.BaseButton)

local function SwitchInput(Props)
	Props.SwitchedOn = EnsureProp(Props.SwitchedOn, "boolean", false)
	Props.Disabled = EnsureProp(Props.Disabled, "boolean", false)

	return Finalize(BaseButton {
		Name = Props.Name or "SwitchInput",
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		ZIndex = Props.ZIndex,
		Selectable = Props.Selectable,

		OnActivated = function()
			if not Props.Disabled:get() then
				Props.SwitchedOn:set(not Props.SwitchedOn:get())
			end
		end,

		[Children] = {
			New "Frame" {
				Name = "Switch",
				Size = UDim2.fromOffset(50, 25),
				BackgroundColor3 = Color3.fromRGB(17, 17, 17),
				BackgroundTransparency = 0,

				[Children] = {
					New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Spring(
							Computed(function()
								if Props.Disabled:get() then
									return Color3.fromRGB(40, 40, 40)
								end
								if Props.SwitchedOn:get() then
									return Color3.fromRGB(65, 65, 65)
								else
									return Color3.fromRGB(50, 50, 50)
								end
							end),
							30,
							1
						),
						Thickness = 2,
					},
					New "UICorner" {
						CornerRadius = UDim.new(0.5, 0),
					},
					New "UIPadding" {
						PaddingBottom = UDim.new(0, 3),
						PaddingLeft = UDim.new(0, 4),
						PaddingRight = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 3),
					},

					New "Frame" {
						Name = "Ball",
						AnchorPoint = Spring(
							Computed(function()
								return (Props.SwitchedOn:get() and Vector2.new(1, 0.5)) or Vector2.new(0, 0.5)
							end),
							40,
							1
						),
						Position = Spring(
							Computed(function()
								return (Props.SwitchedOn:get() and UDim2.fromScale(1, 0.5)) or UDim2.fromScale(0, 0.5)
							end),
							40,
							1
						),
						Size = UDim2.fromScale(0, 1),
						BackgroundColor3 = Spring(
							Computed(function()
								if Props.Disabled:get() then
									return Color3.fromRGB(35, 35, 35)
								end
								if Props.SwitchedOn:get() then
									return Color3.fromRGB(216, 216, 216)
								else
									return Color3.fromRGB(70, 70, 70)
								end
							end),
							40,
							1
						),

						[Children] = {
							New "UIAspectRatioConstraint" {
								AspectRatio = 1,
								AspectType = Enum.AspectType.ScaleWithParentSize,
								DominantAxis = Enum.DominantAxis.Height,
							},
							New "UICorner" {
								CornerRadius = UDim.new(0.5, 0),
							},
						},
					},
				},
			},
		},
	})
end

return SwitchInput
