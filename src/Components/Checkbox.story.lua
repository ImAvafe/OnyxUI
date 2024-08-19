local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Colors = require(OnyxUI.Utils.Colors)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local Checkbox = require(OnyxUI.Components.Checkbox)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,

			[Children] = {
				Checkbox {},
				Checkbox {
					Checked = true,
				},
				Checkbox {
					Disabled = true,
				},
				Checkbox {
					Disabled = true,
					Checked = true,
				},
				Checkbox {
					Icon = "rbxassetid://16743550373",
					Color = Colors.Red["500"],
					Checked = true,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
