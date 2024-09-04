local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Components = require(OnyxUI.Components)

local Children = Fusion.Children
local Scoped = Fusion.scoped

return {
	story = function(Parent: GuiObject)
		local Theme: Themer.ThemeObject = Themer.Theme:now()
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)

		local Instance = Scope:Base {
			Parent = Parent,
			ListEnabled = true,
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["4"]))
			end),

			[Children] = {
				Scope:Base {
					ClassName = "Frame",
					Size = UDim2.fromOffset(100, 100),
					CornerRadius = UDim.new(0, 0),
					PaddingLeft = UDim.new(0, 10),
					StrokeThickness = 5,
					StrokeColor = Color3.fromRGB(255, 0, 0),
				},
				Scope:Base {
					ClassName = "Frame",
					ListEnabled = true,
					ListPadding = UDim.new(0, 15),
					-- Size = UDim2.fromOffset(300, 600),
					AutomaticSize = Enum.AutomaticSize.XY,
					PaddingLeft = UDim.new(0, 10),
					Padding = UDim.new(0, 30),

					[Children] = {
						Scope:Base {
							ClassName = "TextButton",
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							StrokeEnabled = true,
							StrokeThickness = 3,
							StrokeApplyMode = Enum.ApplyStrokeMode.Border,
							StrokeTransparency = 0.5,
							StrokeLineJoinMode = Enum.LineJoinMode.Miter,
							Size = UDim2.fromOffset(200, 50),
						},
						Scope:Base {
							ClassName = "TextButton",
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							StrokeEnabled = true,
							StrokeThickness = 3,
							StrokeColor = Color3.fromRGB(0, 0, 0),
							StrokeApplyMode = Enum.ApplyStrokeMode.Border,
							CornerRadius = UDim.new(0, 15),
							Scale = 0.95,
							Size = UDim2.fromOffset(200, 50),
							GradientEnabled = true,
							GradientColor = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0)),
						},
						Scope:Base {
							ClassName = "TextButton",
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							StrokeEnabled = true,
							StrokeThickness = 3,
							StrokeApplyMode = Enum.ApplyStrokeMode.Border,
							Size = UDim2.fromOffset(200, 50),
							AspectRatio = 1,
							DominantAxis = Enum.DominantAxis.Height,
							AspectType = Enum.AspectType.ScaleWithParentSize,
							-- MaxSize = Vector2.new(10, 20),
						},
					},
				},
				Scope:Base {
					ClassName = "Frame",
					Size = UDim2.fromOffset(200, 200),
					GridEnabled = true,
					GridCellSize = UDim2.fromOffset(50, 50),
					BackgroundColor3 = Color3.fromRGB(255, 0, 0),
					Padding = UDim.new(0, 10),
					CornerRadius = UDim.new(0, 10),

					[Children] = {
						Scope:Base {
							ClassName = "Frame",
						},
						Scope:Base {
							ClassName = "Frame",
							StrokeEnabled = true,
							StrokeColor = Color3.fromRGB(0, 0, 255),
							StrokeThickness = 2,
						},
						Scope:Base {
							ClassName = "Frame",
						},
						Scope:Base {
							ClassName = "Frame",
						},
						Scope:Base {
							ClassName = "Frame",
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
