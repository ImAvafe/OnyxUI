local SoundService = game:GetService("SoundService")

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local OnEvent = Fusion.OnEvent
local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	Disabled: PubTypes.CanBeState<boolean>?,

	OnActivated: PubTypes.CanBeState<() -> ()>?,
	OnMouseEnter: PubTypes.CanBeState<() -> ()>?,
	OnMouseLeave: PubTypes.CanBeState<() -> ()>?,
	OnMouseButton1Down: PubTypes.CanBeState<() -> ()>?,
	OnMouseButton1Up: PubTypes.CanBeState<() -> ()>?,

	IsHovering: PubTypes.CanBeState<boolean>?,
	IsHolding: PubTypes.CanBeState<boolean>?,

	HoverSound: PubTypes.CanBeState<Sound>?,
	ClickSound: PubTypes.CanBeState<Sound>?,
}

return function(Props: Props)
	local Disabled = Util.EnsureValue(Props.Disabled, "boolean", false)

	local IsHovering = Util.EnsureValue(Props.IsHovering, "boolean", false)
	local IsHolding = Util.EnsureValue(Props.IsHolding, "boolean", false)

	local OnActivated = Util.EnsureValue(Props.OnActivated, "function", function() end)
	local OnMouseEnter = Util.EnsureValue(Props.OnMouseEnter, "function", function() end)
	local OnMouseLeave = Util.EnsureValue(Props.OnMouseLeave, "function", function() end)
	local OnMouseButton1Down = Util.EnsureValue(Props.OnMouseButton1Down, "function", function() end)
	local OnMouseButton1Up = Util.EnsureValue(Props.OnMouseButton1Up, "function", function() end)

	local HoverSound = Util.EnsureValue(Props.HoverSound, "Sound", Themer.Theme.Sound.Hover)
	local ClickSound = Util.EnsureValue(Props.ClickSound, "Sound", Themer.Theme.Sound.Click)

	local Active = Util.EnsureValue(
		Props.Active,
		"boolean",
		Computed(function()
			return not Disabled:get()
		end)
	)
	local Selectable = Util.EnsureValue(
		Props.Selectable,
		"boolean",
		Computed(function()
			return not Disabled:get()
		end)
	)

	return Hydrate(Base(Util.CombineProps(Props, {
		ClassName = "TextButton",
		Name = "BaseButton",
		AutomaticSize = Enum.AutomaticSize.XY,
		Selectable = Selectable,
		BackgroundTransparency = 1,
	}))) {
		Text = "",
		RichText = false,
		TextSize = 0,
		AutoLocalize = false,

		[OnEvent "Activated"] = function()
			if not Disabled:get() then
				SoundService:PlayLocalSound(ClickSound:get())
				OnActivated:get()()
			end
		end,
		[OnEvent "MouseEnter"] = function()
			if Active:get() then
				SoundService:PlayLocalSound(HoverSound:get())
			end
			IsHovering:set(true)
			OnMouseEnter:get()()
		end,
		[OnEvent "SelectionGained"] = function()
			if Active:get() then
				SoundService:PlayLocalSound(HoverSound:get())
			end
			IsHovering:set(true)
			OnMouseEnter:get()()
		end,
		[OnEvent "MouseLeave"] = function()
			IsHovering:set(false)
			IsHolding:set(false)
			OnMouseLeave:get()()
		end,
		[OnEvent "MouseButton1Down"] = function()
			if not Disabled:get() then
				IsHolding:set(true)
				OnMouseButton1Down:get()()
			end
		end,
		[OnEvent "MouseButton1Up"] = function()
			IsHolding:set(false)
			OnMouseButton1Up:get()()
		end,
	}
end
