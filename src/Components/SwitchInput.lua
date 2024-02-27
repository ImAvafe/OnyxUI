local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local BaseButton = require(OnyxUI.Components.BaseButton)

local function SwitchInput(Props: table)
	Props.SwitchedOn = EnsureValue(Props.SwitchedOn, "boolean", false)
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)

	Props.Name = EnsureValue(Props.Name, "string", "SwitchInput")
	Props.Size = EnsureValue(Props.Size, "UDim2", UDim2.fromOffset(50, 25))
	Props.Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Space:get())
		end)
	)

	local ContentColor = Computed(function()
		if Props.SwitchedOn:get() then
			return Themer.Theme.Colors.Primary.Main:get()
		else
			return Themer.Theme.Colors.NeutralContent.Dark:get()
		end
	end)

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
			New "UIPadding" {
				PaddingTop = UDim.new(0, 2),
				PaddingBottom = UDim.new(0, 2),
				PaddingRight = UDim.new(0, 2),
				PaddingLeft = UDim.new(0, 2),
			},
			New "Frame" {
				Name = "Switch",
				Size = Props.Size,
				BackgroundColor3 = Themer.Theme.Colors.Base.Light,
				BackgroundTransparency = 0,

				[Children] = {
					New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Transparency = Spring(
							Computed(function()
								if Props.Disabled:get() then
									return 0.7
								end
								if Props.SwitchedOn:get() then
									return 0
								else
									return 0.6
								end
							end),
							30,
							1
						),
						Color = Spring(ContentColor, 30, 1),
						Thickness = Themer.Theme.StrokeThickness,
					},
					New "UICorner" {
						CornerRadius = Computed(function()
							return UDim.new(0, Themer.Theme.CornerRadius:get() * 2)
						end),
					},
					New "UIPadding" {
						PaddingBottom = Props.Padding,
						PaddingLeft = Props.Padding,
						PaddingRight = Props.Padding,
						PaddingTop = Props.Padding,
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
						BackgroundTransparency = Spring(
							Computed(function()
								if Props.Disabled:get() then
									return 0.7
								end
								if Props.SwitchedOn:get() then
									return 0
								else
									return 0
								end
							end),
							30,
							1
						),
						BackgroundColor3 = Spring(ContentColor, 40, 1),

						[Children] = {
							New "UIAspectRatioConstraint" {
								AspectRatio = 1,
								AspectType = Enum.AspectType.ScaleWithParentSize,
								DominantAxis = Enum.DominantAxis.Height,
							},
							New "UICorner" {
								CornerRadius = Computed(function()
									return UDim.new(0, Themer.Theme.CornerRadius:get() * 2)
								end),
							},
						},
					},
				},
			},
		},
	})
end

return SwitchInput
