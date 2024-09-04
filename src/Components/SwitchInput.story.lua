local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local SwitchInput = require(script.Parent.SwitchInput)
local Frame = require(script.Parent.Frame)
local Components = {
	SwitchInput = SwitchInput,
	Frame = Frame,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		Scope:Frame {
			Parent = Parent,
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["1"]))
			end),
			ListEnabled = true,
			ListPadding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.Spacing["0.5"]))
			end),

			[Children] = {
				Scope:SwitchInput {},
				Scope:SwitchInput {
					Disabled = true,
				},
			},
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
