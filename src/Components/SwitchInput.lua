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
	Props.Size = EnsureValue(
		Props.Size,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.TextSize["1.125"]:get() * 2, Themer.Theme.TextSize["1.125"]:get())
		end)
	)
	Props.Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
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
				PaddingTop = Computed(function()
					return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
				end),
				PaddingBottom = Computed(function()
					return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
				end),
				PaddingRight = Computed(function()
					return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
				end),
				PaddingLeft = Computed(function()
					return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
				end),
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
							Themer.Theme.SpringSpeed["1"],
							Themer.Theme.SpringDampening
						),
						Color = Spring(ContentColor, 30, Themer.Theme.SpringDampening),
						Thickness = Themer.Theme.StrokeThickness["1"],
					},
					New "UICorner" {
						CornerRadius = Computed(function()
							return UDim.new(0, Themer.Theme.CornerRadius["2"]:get())
						end),
					},
					New "UIPadding" {
						PaddingBottom = UDim.new(0, 3),
						PaddingLeft = UDim.new(0, 3),
						PaddingRight = UDim.new(0, 3),
						PaddingTop = UDim.new(0, 3),
					},

					New "Frame" {
						Name = "Ball",
						AnchorPoint = Spring(
							Computed(function()
								return (Props.SwitchedOn:get() and Vector2.new(1, 0.5)) or Vector2.new(0, 0.5)
							end),
							Themer.Theme.SpringSpeed["1"],
							Themer.Theme.SpringDampening
						),
						Position = Spring(
							Computed(function()
								return (Props.SwitchedOn:get() and UDim2.fromScale(1, 0.5)) or UDim2.fromScale(0, 0.5)
							end),
							Themer.Theme.SpringSpeed["1"],
							Themer.Theme.SpringDampening
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
							Themer.Theme.SpringSpeed["1"],
							Themer.Theme.SpringDampening
						),
						BackgroundColor3 = Spring(ContentColor, 40, Themer.Theme.SpringDampening),

						[Children] = {
							New "UIAspectRatioConstraint" {
								AspectRatio = 1,
								AspectType = Enum.AspectType.ScaleWithParentSize,
								DominantAxis = Enum.DominantAxis.Height,
							},
							New "UICorner" {
								CornerRadius = Computed(function()
									return UDim.new(0, Themer.Theme.CornerRadius["2"]:get())
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
