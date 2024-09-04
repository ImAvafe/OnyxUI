--[=[
		@class BaseButton
		
		A barebones button component, like if Roblox had a "`Button`" class rather than only a `TextButton`.
]=]

local SoundService = game:GetService("SoundService")

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local peek = Fusion.peek
local OnEvent = Fusion.OnEvent

local Base = require(script.Parent.Base)
local Components = {
	Base = Base,
}

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

return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Disabled = Util.Fallback(Props.Disabled, false)
	local IsHovering = Util.Fallback(Props.IsHovering, false)
	local IsHolding = Util.Fallback(Props.IsHolding, false)
	local OnActivated = Util.Fallback(Props.OnActivated, function() end)
	local OnMouseEnter = Util.Fallback(Props.OnMouseEnter, function() end)
	local OnMouseLeave = Util.Fallback(Props.OnMouseLeave, function() end)
	local OnMouseButton1Down = Util.Fallback(Props.OnMouseButton1Down, function() end)
	local OnMouseButton1Up = Util.Fallback(Props.OnMouseButton1Up, function() end)
	local HoverSound = Util.Fallback(Props.HoverSound, Theme.Sound.Hover)
	local ClickSound = Util.Fallback(Props.ClickSound, Theme.Sound.Click)
	local Active = Util.Fallback(
		Props.Active,
		Scope:Computed(function(use)
			return not use(Disabled)
		end)
	)
	local Selectable = Util.Fallback(
		Props.Selectable,
		Scope:Computed(function(use)
			return not use(Disabled)
		end)
	)

	return Scope:Hydrate(Scope:Base(Util.CombineProps(Props, {
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
			if not peek(Disabled) then
				SoundService:PlayLocalSound(peek(ClickSound))
				peek(OnActivated)()
			end
		end,
		[OnEvent "MouseEnter"] = function()
			if peek(Active) then
				SoundService:PlayLocalSound(peek(HoverSound))
			end
			IsHovering:set(true)
			peek(OnMouseEnter)()
		end,
		[OnEvent "SelectionGained"] = function()
			if peek(Active) then
				SoundService:PlayLocalSound(peek(HoverSound))
			end
			IsHovering:set(true)
			peek(OnMouseEnter)()
		end,
		[OnEvent "MouseLeave"] = function()
			IsHovering:set(false)
			IsHolding:set(false)
			peek(OnMouseLeave)()
		end,
		[OnEvent "MouseButton1Down"] = function()
			if not peek(Disabled) then
				IsHolding:set(true)
				peek(OnMouseButton1Down)()
			end
		end,
		[OnEvent "MouseButton1Up"] = function()
			IsHolding:set(false)
			peek(OnMouseButton1Up)()
		end,
	}
end
