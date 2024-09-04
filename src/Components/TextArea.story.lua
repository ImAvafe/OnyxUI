local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Scoped = Fusion.scoped

local TextArea = require(script.Parent.TextArea)
local Frame = require(script.Parent.Frame)
local Components = {
	TextArea = TextArea,
	Frame = Frame,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local Instance = Scope:Frame {
			Parent = Parent,
			Size = UDim2.fromOffset(250, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListPadding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.Spacing["0.5"]))
			end),
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["1"]))
			end),

			[Children] = {
				Scope:TextArea {
					Size = Scope:Computed(function(use)
						return UDim2.new(
							UDim.new(1, 0),
							UDim.new(0, use(Theme.TextSize["1"]) * 2) + use(Theme.Spacing["0.5"]) * 2
						)
					end),
				},
				Scope:TextArea {
					Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 100)),
					CharacterLimit = 60,
					PlaceholderText = "This TextArea has a character limit.",
				},
				Scope:TextArea {
					Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 0)),
					AutomaticSize = Enum.AutomaticSize.Y,
					PlaceholderText = "This one will expand as you type.",
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
