local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

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
			ListEnabled = true,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),

			[Children] = {
				TextInput {
					PlaceholderText = "You can type here!",
				},
				TextInput {
					PlaceholderText = "You cannot type here!",
					Disabled = true,
				},
				TextInput {
					PlaceholderText = "Twenty characters only!",
					CharacterLimit = 20,
				},
				TextInput {
					PlaceholderText = "Something dangerous!",
					Color = Themer.Theme.Colors.Error.Main,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
