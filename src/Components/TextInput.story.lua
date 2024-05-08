local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local Modifier = require(OnyxUI.Utils.Modifier)

local Children = Fusion.Children
local Computed = Fusion.Computed

local TextInput = require(script.Parent.TextInput)
local Frame = require(script.Parent.Frame)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			Size = UDim2.fromOffset(300, 0),
			AutomaticSize = Enum.AutomaticSize.Y,

			[Children] = {
				Modifier.ListLayout {},
				Modifier.Padding {
					Padding = Computed(function()
						return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
					end),
				},

				TextInput {
					PlaceholderText = "You can type here!",
				},
				TextInput {
					PlaceholderText = "You can't type here!",
					Disabled = true,
				},
				TextInput {
					PlaceholderText = "Twenty characters only!",
					CharacterLimit = 20,
				},
				TextInput {
					PlaceholderText = "Description..",
					CharacterLimit = 80,
					Multiline = true,
					TextWrapped = true,
					Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 80)),
					AutomaticSize = Enum.AutomaticSize.None,
				},
				TextInput {
					PlaceholderText = "This one wrap-expands!",
					Multiline = true,
					TextWrapped = true,
					Size = UDim2.fromScale(1, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
