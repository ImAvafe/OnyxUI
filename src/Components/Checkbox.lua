local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)
local Modifier = require(OnyxUI.Utils.Modifier)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local BaseButton = require(OnyxUI.Components.BaseButton)
local Icon = require(OnyxUI.Components.Icon)

local DISABLED_BACKGROUND_TRANSPARENCY = 0.925
local DISABLED_CONTENT_TRANSPARENCY = 0.75

return function(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Checkbox")

	Props.Checked = EnsureValue(Props.Checked, "boolean", false)
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)
	Props.Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.ContrastColor = EnsureValue(
		Props.ContrastColor,
		"Color3",
		Computed(function()
			return ColourUtils.Emphasise(Props.Color:get(), 1)
		end)
	)
	Props.Icon = EnsureValue(Props.Icon, "string", "rbxassetid://16743325652")

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

		BackgroundColor3 = Computed(function()
			if Props.Disabled:get() then
				return Themer.Theme.Colors.BaseContent.Main:get()
			else
				return Props.Color:get()
			end
		end),
		BackgroundTransparency = Spring(
			Computed(function()
				if Props.Disabled:get() then
					return DISABLED_BACKGROUND_TRANSPARENCY
				else
					if Props.Checked:get() then
						return 0
					else
						return 1
					end
				end
			end),
			Themer.Theme.SpringSpeed["1"],
			Themer.Theme.SpringDampening
		),

		Disabled = Props.Disabled,
		OnActivated = function()
			Props.Checked:set(not Props.Checked:get())
		end,

		[Children] = {
			Modifier.Corner {
				CornerRadius = Computed(function()
					return UDim.new(0, Themer.Theme.CornerRadius["0.5"]:get())
				end),
			},
			Modifier.Stroke {
				Color = Computed(function()
					if Props.Disabled:get() then
						return Themer.Theme.Colors.BaseContent.Main:get()
					else
						return Props.Color:get()
					end
				end),
				Transparency = Computed(function()
					if Props.Disabled:get() then
						return DISABLED_BACKGROUND_TRANSPARENCY
					else
						return 0
					end
				end),
			},

			Icon {
				Name = "CheckIcon",
				Image = Props.Icon,
				ImageTransparency = Spring(
					Computed(function()
						if Props.Checked:get() then
							if Props.Disabled:get() then
								return DISABLED_CONTENT_TRANSPARENCY
							else
								return 0
							end
						else
							return 1
						end
					end),
					Themer.Theme.SpringSpeed["1"],
					Themer.Theme.SpringDampening
				),
				ImageColor3 = Props.ContrastColor,
				Rotation = Spring(
					Computed(function()
						return (Props.Checked:get() and 0) or -30
					end),
					Themer.Theme.SpringSpeed["1"],
					Themer.Theme.SpringDampening
				),
			},
		},
	}
end
