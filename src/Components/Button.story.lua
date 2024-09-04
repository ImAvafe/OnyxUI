local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local Button = require(script.Parent.Button)
local Frame = require(script.Parent.Frame)
local Components = {
	Button = Button,
	Frame = Frame,
}

return {
	clipsDescendants = false,
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		Scope:Frame {
			Parent = Parent,
			ListEnabled = true,
			ListPadding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.Spacing["0.5"]))
			end),
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["1"]))
			end),

			[Children] = {
				Scope:Button {
					Content = { "Button" },
				},
				Scope:Button {
					Content = { "Button" },
					Color = Theme.Colors.Primary.Main,
				},
				Scope:Button {
					Content = { "Button" },
					Style = "Outlined",
					Color = Theme.Colors.Primary.Main,
				},
				Scope:Button {
					Content = { "rbxassetid://11560341132", "Purchase" },
					Color = Color3.fromRGB(86, 255, 70),
				},
				Scope:Button {
					Content = { "rbxassetid://13405228418", "Delete" },
					Style = "Outlined",
					Color = Theme.Colors.Error.Main,
				},
				Scope:Button {
					Content = { "Ghost" },
					Style = "Ghost",
					Color = Theme.Colors.BaseContent.Main,
				},
				Scope:Button {
					Content = { "rbxassetid://11560341132", "Bobux" },
					Color = Color3.fromRGB(86, 255, 70),
					Disabled = true,
				},
				Scope:Button {
					Content = { "Testing" },
					Color = Color3.fromRGB(86, 255, 70),
					Disabled = true,
					Style = "Outlined",
				},
			},
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
