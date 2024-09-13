local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
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
		local Scope = Scoped(Fusion, Components)
		local Theme = Themer.Theme:now()

		Scope:Frame {
			Parent = Parent,
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.StrokeThickness["1"]))
			end),
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.5"]))
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
			Scope:doCleanup()
		end
	end,
}
