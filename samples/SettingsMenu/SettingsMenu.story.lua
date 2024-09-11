local OnyxUI = script.Parent.Parent.Parent.OnyxUI.Packages.OnyxUI
local Fusion = require(OnyxUI.TypedPackages.Fusion)
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

return function(Parent: GuiObject)
	local Scope = Scoped(Fusion, Components)
	local Theme = Themer.Theme:now()

	Scope:Frame {
		Parent = Parent,
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

	return function()
		Scope:doCleanup()
	end
end
