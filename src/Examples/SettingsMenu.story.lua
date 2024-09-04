local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Scoped = Fusion.scoped

local Frame = require(OnyxUI.Components.Frame)
local SettingsMenu = require(OnyxUI.Examples.SettingsMenu)
local Components = {
	Frame = Frame,
	SettingsMenu = SettingsMenu,
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

			[Children] = {
				Scope:SettingsMenu {},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
