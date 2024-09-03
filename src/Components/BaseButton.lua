--[=[
		@class BaseButton
		
		A barebones button component, like if Roblox had a "`Button`" class rather than only a `TextButton`.
]=]

local SoundService = game:GetService("SoundService")

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local OnEvent = Fusion.OnEvent
local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

--[=[
		@within BaseButton
		@interface BaseButtonProps

		@field ... BaseProps
		@field Disabled Fusion.UsedAs<boolean>?
		@field OnActivated Fusion.UsedAs<() -> ()>?
		@field OnMouseEnter Fusion.UsedAs<() -> ()>?
		@field OnMouseLeave Fusion.UsedAs<() -> ()>?
		@field OnMouseButton1Down Fusion.UsedAs<() -> ()>?
		@field OnMouseButton1Up Fusion.UsedAs<() -> ()>?
		@field IsHovering Fusion.UsedAs<boolean>?
		@field IsHolding Fusion.UsedAs<boolean>?
		@field HoverSound Fusion.UsedAs<Sound>?
		@field ClickSound Fusion.UsedAs<Sound>?
]=]
export type Props = Base.Props & {
	Disabled: Fusion.UsedAs<boolean>?,

	OnActivated: Fusion.UsedAs<() -> ()>?,
	OnMouseEnter: Fusion.UsedAs<() -> ()>?,
	OnMouseLeave: Fusion.UsedAs<() -> ()>?,
	OnMouseButton1Down: Fusion.UsedAs<() -> ()>?,
	OnMouseButton1Up: Fusion.UsedAs<() -> ()>?,

	IsHovering: Fusion.UsedAs<boolean>?,
	IsHolding: Fusion.UsedAs<boolean>?,

	HoverSound: Fusion.UsedAs<Sound>?,
	ClickSound: Fusion.UsedAs<Sound>?,
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
