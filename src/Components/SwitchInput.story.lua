local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local SwitchInput = require(script.Parent.SwitchInput)
local Frame = require(script.Parent.Frame)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),
			ListEnabled = true,

			[Children] = {
				SwitchInput {},
				SwitchInput {
					Disabled = true,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
