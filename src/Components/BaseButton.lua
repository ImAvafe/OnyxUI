local SoundService = game:GetService("SoundService")

local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local PubTypes = require(script.Parent.Parent.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

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

local function Button(Props: Props): () -> TextButton
	local Name = EnsureValue(Props.Name, "string", "BaseButton")
	local BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)
	local AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)

	local Disabled = EnsureValue(Props.Disabled, "boolean", false)

	local IsHovering = EnsureValue(Props.IsHovering, "boolean", false)
	local IsHolding = EnsureValue(Props.IsHolding, "boolean", false)

	local OnActivated = EnsureValue(Props.OnActivated, "function", function() end)
	local OnMouseEnter = EnsureValue(Props.OnMouseEnter, "function", function() end)
	local OnMouseLeave = EnsureValue(Props.OnMouseLeave, "function", function() end)
	local OnMouseButton1Down = EnsureValue(Props.OnMouseButton1Down, "function", function() end)
	local OnMouseButton1Up = EnsureValue(Props.OnMouseButton1Up, "function", function() end)

	local HoverSound = EnsureValue(Props.HoverSound, "Sound", Themer.Theme.Sound.Hover)
	local ClickSound = EnsureValue(Props.ClickSound, "Sound", Themer.Theme.Sound.Click)

	local Active = EnsureValue(
		Props.Active,
		"boolean",
		Computed(function()
			return not Disabled:get()
		end)
	)
	local Selectable = EnsureValue(
		Props.Selectable,
		"boolean",
		Computed(function()
			return not Disabled:get()
		end)
	)

	return Hydrate(Base(CombineProps(Props, {
		ClassName = "TextButton",
		Name = Name,
		AutomaticSize = AutomaticSize,
		Selectable = Selectable,
		BackgroundTransparency = BackgroundTransparency,
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

return Button
