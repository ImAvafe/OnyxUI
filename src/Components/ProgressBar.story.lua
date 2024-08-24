local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Children = Fusion.Children
local Value = Fusion.Value
local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)
local ProgressBar = require(script.Parent.ProgressBar)
local Text = require(script.Parent.Text)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Progress = Value(0)
		local Color = Value(Color3.fromRGB(255, 0, 0))

		local Instance = Frame {
			Parent = Parent,
			ListEnabled = true,

			[Children] = {
				ProgressBar {
					Progress = 0.75,
				},
				ProgressBar {
					Progress = Progress,
					Color = Color,
				},
				ProgressBar {
					Progress = Progress,
					Color = Color,
				},
				Frame {
					ListEnabled = true,
					ListFillDirection = Enum.FillDirection.Horizontal,
					ListVerticalAlignment = Enum.VerticalAlignment.Center,

					[Children] = {
						Text {
							Text = "Label",
						},
						ProgressBar {
							Progress = Progress,
							Color = Util.Colors.Emerald["500"],
							Size = Computed(function()
								return UDim2.fromOffset(150, Themer.Theme.TextSize["0.75"]:get())
							end),
						},
					},
				},
				ProgressBar {
					Progress = Progress,
					Inverted = true,
				},
				ProgressBar {
					Direction = Enum.FillDirection.Vertical,
					Progress = Progress,
					Inverted = true,
				},
				ProgressBar {
					Progress = Progress,
					Color = Color,
					CornerRadius = UDim.new(0, 0),
				},
			},
		}

		task.spawn(function()
			while task.wait(1) do
				Progress:set(math.random(0, 1000) / 1000)
				Color:set(ColorUtils.Rotate(Color:get(), 100))
			end
		end)

		return function()
			Instance:Destroy()
		end
	end,
}
