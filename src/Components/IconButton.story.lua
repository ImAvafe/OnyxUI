local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local IconButton = require(script.Parent.IconButton)
local Frame = require(script.Parent.Frame)
local Components = {
	IconButton = IconButton,
	Frame = Frame,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local Instance = Scope:Frame {
			Parent = Parent,
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["1"]))
			end),
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,
			ListPadding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.Spacing["0.5"]))
			end),

			[Children] = {
				Scope:IconButton {
					Image = "rbxassetid://10814531047",
				},
				Scope:IconButton {
					Image = "rbxassetid://10814531047",
					Color = Theme.Colors.Primary.Main,
				},
				Scope:IconButton {
					Image = "rbxassetid://11560341132",
					Color = Util.Colors.Amber["500"],
				},
				Scope:IconButton {
					Image = "rbxassetid://13405228418",
					Color = Util.Colors.Red["500"],
					Style = "Outlined",
				},
				Scope:IconButton {
					Image = "rbxassetid://13405228418",
					Color = Util.Colors.Red["500"],
					Style = "Ghost",
				},
				Scope:IconButton {
					Image = "rbxassetid://10814531047",
					Disabled = true,
				},
				Scope:IconButton {
					Image = "rbxassetid://10814531047",
					Style = "Ghost",
					Disabled = true,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
