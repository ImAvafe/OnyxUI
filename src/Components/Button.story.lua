local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Button = require(script.Parent.Button)
local Frame = require(script.Parent.Frame)

return {
	clipsDescendants = false,
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			ListEnabled = true,
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
			end),
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),

			[Children] = {
				Button {
					Content = { "Button" },
				},
				Button {
					Content = { "Button" },
					Color = Themer.Theme.Colors.Primary.Main,
				},
				Button {
					Content = { "Button" },
					Style = "Outlined",
					Color = Themer.Theme.Colors.Primary.Main,
				},
				Button {
					Content = { "rbxassetid://11560341132", "Purchase" },
					Color = Color3.fromRGB(86, 255, 70),
				},
				Button {
					Content = { "rbxassetid://13405228418", "Delete" },
					Style = "Outlined",
					Color = Themer.Theme.Colors.Error.Main,
				},
				Button {
					Content = { "Ghost" },
					Style = "Ghost",
				},
				Button {
					Content = { "rbxassetid://11560341132", "Bobux" },
					Color = Color3.fromRGB(86, 255, 70),
					Disabled = true,
				},
				Button {
					Content = { "Testing" },
					Color = Color3.fromRGB(86, 255, 70),
					Disabled = true,
					Style = "Outlined",
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
