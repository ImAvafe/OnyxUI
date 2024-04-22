local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local Modifier = require(OnyxUI.Utils.Modifier)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local Frame = require(OnyxUI.Components.Frame)
local BaseButton = require(OnyxUI.Components.BaseButton)

local function SwitchInput(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "SwitchInput")
	Props.Size = EnsureValue(
		Props.Size,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.TextSize["1"]:get() * 2, Themer.Theme.TextSize["1"]:get())
		end)
	)

	Props.SwitchedOn = EnsureValue(Props.SwitchedOn, "boolean", false)
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)

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
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		ClickSound = Themer.Theme.Sound.Switch,

		Disabled = Props.Disabled,

		OnActivated = function()
			Props.SwitchedOn:set(not Props.SwitchedOn:get())
		end,

		[Children] = {
			Frame {
				Name = "Switch",
				Size = Props.Size,
				AutomaticSize = Enum.AutomaticSize.None,
				BackgroundColor3 = Themer.Theme.Colors.Base.Light,
				BackgroundTransparency = 0,

				[Children] = {
					Modifier.Stroke {
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
					},
					Modifier.Corner {
						CornerRadius = Computed(function()
							return UDim.new(0, Themer.Theme.CornerRadius["2"]:get())
						end),
					},
					Modifier.Padding {
						Padding = UDim.new(0, 3),
					},

					Frame {
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
						AutomaticSize = Enum.AutomaticSize.None,
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
							Modifier.AspectRatioConstraint {
								AspectRatio = 1,
								AspectType = Enum.AspectType.ScaleWithParentSize,
								DominantAxis = Enum.DominantAxis.Height,
							},
							Modifier.Corner {
								CornerRadius = Computed(function()
									return UDim.new(0, Themer.Theme.CornerRadius["2"]:get())
								end),
							},
						},
					},
				},
			},
		},
	}
end

return SwitchInput
