local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local DropdownHandler = require(script.DropdownHandler)

local Base = require(OnyxUI.Components.Base)
local Components = {
	TextInput = require(OnyxUI.Components.TextInput),
	Scroller = require(OnyxUI.Components.Scroller),
	Button = require(OnyxUI.Components.Button),
	Group = require(OnyxUI.Components.Group),
}

export type Props = Base.Props & {
	Open: Fusion.UsedAs<boolean>?,
	Items: Fusion.UsedAs<{ string }>?,
	Selection: Fusion.UsedAs<string>?,
	PlaceholderText: Fusion.UsedAs<string>?,
}

local Scope = Fusion.scoped(Fusion, Components, Util)

return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = Fusion.innerScope(Scope, Fusion, Components, Util)
	local Theme = Themer.Theme:now()

	local Open = Scope:EnsureValue(Util.Fallback(Props.Open, false))
	local Items = Util.Fallback(Props.Items, {})
	local Selection = Scope:EnsureValue(Util.Fallback(Props.Selection, nil))
	local PlaceholderText = Util.Fallback(Props.PlaceholderText, "Dropdown")
	local OnSelected = Util.Fallback(Props.OnSelected, function() end)

	local Text = Scope:Value("")
	Scope:Observer(Selection):onChange(function()
		local SelectionValue = tostring(Fusion.peek(Selection))
		Text:set(SelectionValue or "")
	end)

	local Object
	local OnFocused = function()
		DropdownHandler.Object:set(Object)
		DropdownHandler.Items:set(Items)
		DropdownHandler.Selection:set(Selection)
		DropdownHandler.Theme:set(Theme)
		DropdownHandler.OnSelected:set(function()
			OnSelected()

			Object:ReleaseFocus()
		end)
	end

	Object = Scope:TextInput(Util.CombineProps(Props, {
		Name = script.Name,
		Parent = Props.Parent,
		Text = Text,
		PlaceholderText = Scope:Computed(function(Use)
			if Use(Selection) then
				return Use(Selection)
			else
				return Use(PlaceholderText)
			end
		end),

		IsFocused = Open,
		OnFocused = OnFocused,
		-- OnFocusLost = function()
		-- 	task.wait(0.1)
		-- 	DropdownHandler.FocusLost:Fire()
		-- end,
	}))

	return Object
end
