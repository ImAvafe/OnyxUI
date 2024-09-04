local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Scoped = Fusion.scoped

local MenuFrame = require(script.Parent.MenuFrame)
local Frame = require(script.Parent.Frame)
local Text = require(script.Parent.Text)
local Components = {
	MenuFrame = MenuFrame,
	Text = Text,
	Frame = Frame,
}

return {
	story = function(Parent: GuiObject, _Props)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local Instance = Scope:Frame {
			Parent = Parent,
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["1"]))
			end),
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,

			[Children] = {
				Scope:MenuFrame {
					Parent = Parent,
					Size = UDim2.fromOffset(300, 200),
					AutomaticSize = Enum.AutomaticSize.None,

					[Children] = {
						Scope:Text {
							Text = "Here's a MenuFrame with some text in it.",
						},
					},
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
