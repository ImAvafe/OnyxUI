local OnyxUI = script.Parent.Parent.Parent.OnyxUI.Packages.OnyxUI
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local BitCave = require(script.Parent.Parent.Themes.BitCave)

local Children = Fusion.Children
local Scoped = Fusion.scoped

local Frame = require(OnyxUI.Components.Frame)
local SettingsMenu = require(script.Parent)
local Components = {
	Frame = Frame,
	SettingsMenu = SettingsMenu,
}

return {
	story = function(Props)
		local Scope = Fusion.innerScope(Props.scope, Fusion, Components)
		local Theme = Themer.Theme:now()

		Scope:Frame {
			Parent = Props.target,
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.StrokeThickness["1"]))
			end),
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,

			[Children] = {
				Scope:SettingsMenu {},
				Themer.Theme:is(BitCave):during(function()
					return Scope:SettingsMenu {
						Size = UDim2.fromOffset(380, 0),
					}
				end),
			},
		}
	end,
	fusion = Fusion,
}
