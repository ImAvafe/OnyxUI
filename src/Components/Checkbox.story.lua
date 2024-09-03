local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

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
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
			end),

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
