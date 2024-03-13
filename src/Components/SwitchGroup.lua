local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local Children = Fusion.Children

local BaseButton = require(OnyxUI.Components.BaseButton)

local function SwitchGroup(Props: table)
	Props.SwitchedOn = EnsureValue(Props.SwitchedOn, "boolean", false)
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)

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

		[Children] = Props[Children],
	}
end

return SwitchGroup
