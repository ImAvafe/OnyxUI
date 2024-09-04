local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Checkbox = require(OnyxUI.Components.Checkbox)
local Components = {
	Frame = Frame,
	Checkbox = Checkbox,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local Instance = Scope:Frame {
			Parent = Parent,
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["1"]))
			end),
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,
			ListPadding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.Spacing["0.5"]))
			end),

			[Children] = {
				Scope:Checkbox {},
				Scope:Checkbox {
					Checked = true,
				},
				Scope:Checkbox {
					Disabled = true,
				},
				Scope:Checkbox {
					Disabled = true,
					Checked = true,
				},
				Scope:Checkbox {
					Icon = "rbxassetid://16743550373",
					Color = Util.Colors.Red["500"],
					Checked = true,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
