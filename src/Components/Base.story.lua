local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)
local Base = require(script.Parent.Base)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			ListEnabled = true,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["4"]:get())
			end),

			[Children] = {
				Base {
					ClassName = "Frame",
					Size = UDim2.fromOffset(100, 100),
					CornerRadius = UDim.new(0, 0),
					PaddingLeft = UDim.new(0, 10),
					StrokeThickness = 5,
					StrokeColor = Color3.fromRGB(255, 0, 0),
				},
				Base {
					ClassName = "Frame",
					ListEnabled = true,
					ListPadding = UDim.new(0, 15),
					-- Size = UDim2.fromOffset(300, 600),
					AutomaticSize = Enum.AutomaticSize.XY,
					PaddingLeft = UDim.new(0, 10),
					Padding = UDim.new(0, 30),

					[Children] = {
						Base {
							ClassName = "TextButton",
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							StrokeEnabled = true,
							StrokeThickness = 3,
							StrokeApplyMode = Enum.ApplyStrokeMode.Border,
							StrokeTransparency = 0.5,
							StrokeLineJoinMode = Enum.LineJoinMode.Miter,
							Size = UDim2.fromOffset(200, 50),
						},
						Base {
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
						Base {
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
				Base {
					ClassName = "Frame",
					Size = UDim2.fromOffset(200, 200),
					GridEnabled = true,
					GridCellSize = UDim2.fromOffset(50, 50),
					BackgroundColor3 = Color3.fromRGB(255, 0, 0),
					Padding = UDim.new(0, 10),
					CornerRadius = UDim.new(0, 10),

					[Children] = {
						Base {
							ClassName = "Frame",
						},
						Base {
							ClassName = "Frame",
							StrokeEnabled = true,
							StrokeColor = Color3.fromRGB(0, 0, 255),
							StrokeThickness = 2,
						},
						Base {
							ClassName = "Frame",
						},
						Base {
							ClassName = "Frame",
						},
						Base {
							ClassName = "Frame",
						},
					},
				},
			},
		}

		local WorkspaceObject = Base {
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
