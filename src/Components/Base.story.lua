local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Modifier = require(OnyxUI.Utils.Modifier)
local Themer = require(OnyxUI.Utils.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local Base = require(script.Parent.Base)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,

			[Children] = {
				Modifier.ListLayout {
					Padding = Computed(function()
						return UDim.new(0, Themer.Theme.Spacing["1"]:get())
					end),
					FillDirection = Enum.FillDirection.Horizontal,
				},
				Modifier.Padding {
					Padding = UDim.new(0, Themer.Theme.StrokeThickness["4"]:get()),
				},

				Base "Frame" {
					Size = UDim2.fromOffset(100, 100),
					CornerRadius = UDim.new(0, 0),
					PaddingLeft = UDim.new(0, 10),
					StrokeThickness = 5,
					StrokeColor = Color3.fromRGB(255, 0, 0),
				},
				Base "Frame" {
					ListEnabled = true,
					ListPadding = UDim.new(0, 15),
					Size = UDim2.fromOffset(300, 600),
					PaddingLeft = UDim.new(0, 10),
					-- Padding = UDim.new(0, 50),

					[Children] = {
						Base "TextButton" {
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							StrokeEnabled = true,
							StrokeThickness = 3,
							StrokeApplyMode = Enum.ApplyStrokeMode.Border,
							Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 50)),
						},
						Base "TextButton" {
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							StrokeEnabled = true,
							StrokeThickness = 3,
							StrokeColor = Color3.fromRGB(0, 0, 0),
							StrokeApplyMode = Enum.ApplyStrokeMode.Border,
							CornerRadius = UDim.new(0, 15),
							Scale = 0.95,
							Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 50)),
						},
						Base "TextButton" {
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							StrokeEnabled = true,
							StrokeThickness = 3,
							StrokeApplyMode = Enum.ApplyStrokeMode.Border,
							Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 50)),
						},
					},
				},
			},
		}

		local WorkspaceObject = Base "Frame" {
			Size = UDim2.fromOffset(100, 100),
			CornerRadius = UDim.new(),
			-- Padding = UDim.new(0, 50),
			PaddingLeft = UDim.new(0, 10),
			-- Scale = 1,
			-- StrokeThickness = 5,
			StrokeColor = Color3.fromRGB(255, 0, 0),
			Parent = workspace,
		}

		return function()
			Instance:Destroy()
			WorkspaceObject:Destroy()
		end
	end,
}
