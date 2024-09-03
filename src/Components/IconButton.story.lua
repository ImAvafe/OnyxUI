local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Children = Fusion.Children
local Computed = Fusion.Computed

local IconButton = require(script.Parent.IconButton)
local Frame = require(script.Parent.Frame)

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
				IconButton {
					Image = "rbxassetid://10814531047",
				},
				IconButton {
					Image = "rbxassetid://10814531047",
					Color = Themer.Theme.Colors.Primary.Main,
				},
				IconButton {
					Image = "rbxassetid://11560341132",
					Color = Util.Colors.Amber["500"],
				},
				IconButton {
					Image = "rbxassetid://13405228418",
					Color = Util.Colors.Red["500"],
					Style = "Outlined",
				},
				IconButton {
					Image = "rbxassetid://13405228418",
					Color = Util.Colors.Red["500"],
					Style = "Ghost",
				},
				IconButton {
					Image = "rbxassetid://10814531047",
					Disabled = true,
				},
				IconButton {
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
