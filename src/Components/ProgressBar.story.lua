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
			ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["1.5"]:get())
			end),

			[Children] = {
				Frame {
					ListEnabled = true,
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					ListPadding = Computed(function()
						return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
					end),

					[Children] = {
						Text {
							Text = "Horizontal",
						},
						ProgressBar {
							Progress = 0.75,
						},
						ProgressBar {
							Progress = Progress,
							Color = Color,
						},
					},
				},
				Frame {
					ListEnabled = true,
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					ListPadding = Computed(function()
						return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
					end),

					[Children] = {
						Text {
							Text = "With text",
						},
						Frame {
							ListEnabled = true,
							ListFillDirection = Enum.FillDirection.Horizontal,
							ListVerticalAlignment = Enum.VerticalAlignment.Center,
							ListPadding = Computed(function()
								return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
							end),

							[Children] = {
								Text {
									Text = "HP",
								},
								ProgressBar {
									Progress = Progress,
									Color = Util.Colors.Red["500"],
									FlexMode = Enum.UIFlexMode.Fill,
								},
							},
						},
					},
				},
				Frame {
					ListEnabled = true,
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					ListPadding = Computed(function()
						return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
					end),

					[Children] = {
						Text {
							Text = "Inverted",
						},
						ProgressBar {
							Progress = Progress,
							Inverted = true,
						},
					},
				},
				Frame {
					ListEnabled = true,
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					ListPadding = Computed(function()
						return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
					end),

					[Children] = {
						Text {
							Text = "Vertical",
						},
						Frame {
							ListEnabled = true,
							ListFillDirection = Enum.FillDirection.Horizontal,
							ListPadding = Computed(function()
								return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
							end),

							[Children] = {

								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
							},
						},
					},
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
