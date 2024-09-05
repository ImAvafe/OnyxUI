local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local ColorUtils = require(OnyxUI.Packages.ColorUtils)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped
local Children = Fusion.Children
local Peek = Fusion.peek

local Frame = require(script.Parent.Frame)
local ProgressBar = require(script.Parent.ProgressBar)
local Text = require(script.Parent.Text)
local Components = {
	Frame = Frame,
	ProgressBar = ProgressBar,
	Text = Text,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local Progress = Scope:Value(0)
		local Color = Scope:Value(Color3.fromRGB(255, 0, 0))

		local ColorThread = task.spawn(function()
			while task.wait(1) do
				Progress:set(math.random(0, 1000) / 1000)
				Color:set(ColorUtils.Rotate(Peek(Color), 100))
			end
		end)

		Scope:innerScope({
			function()
				task.cancel(ColorThread)
			end,
		})

		Scope:Frame {
			Parent = Parent,
			ListEnabled = true,
			ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["1.5"]))
			end),

			[Children] = {
				Scope:Frame {
					ListEnabled = true,
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					ListPadding = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.Spacing["0.5"]))
					end),

					[Children] = {
						Scope:Text {
							Text = "Horizontal",
						},
						Scope:ProgressBar {
							Progress = 0.75,
						},
						Scope:ProgressBar {
							Progress = Progress,
							Color = Color,
						},
					},
				},
				Scope:Frame {
					ListEnabled = true,
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					ListPadding = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.Spacing["0.5"]))
					end),

					[Children] = {
						Scope:Text {
							Text = "With text",
						},
						Scope:Frame {
							ListEnabled = true,
							ListFillDirection = Enum.FillDirection.Horizontal,
							ListVerticalAlignment = Enum.VerticalAlignment.Center,
							ListPadding = Scope:Computed(function(Use)
								return UDim.new(0, Use(Theme.Spacing["0.5"]))
							end),

							[Children] = {
								Scope:Text {
									Text = "HP",
								},
								Scope:ProgressBar {
									Progress = Progress,
									Color = Util.Colors.Red["500"],
									FlexMode = Enum.UIFlexMode.Fill,
								},
							},
						},
					},
				},
				Scope:Frame {
					ListEnabled = true,
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					ListPadding = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.Spacing["0.5"]))
					end),

					[Children] = {
						Scope:Text {
							Text = "Inverted",
						},
						Scope:ProgressBar {
							Progress = Progress,
							Inverted = true,
						},
					},
				},
				Scope:Frame {
					ListEnabled = true,
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					ListPadding = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.Spacing["0.5"]))
					end),

					[Children] = {
						Scope:Text {
							Text = "Vertical",
						},
						Scope:Frame {
							ListEnabled = true,
							ListFillDirection = Enum.FillDirection.Horizontal,
							ListPadding = Scope:Computed(function(Use)
								return UDim.new(0, Use(Theme.Spacing["0.5"]))
							end),

							[Children] = {

								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Inverted = true,
									Color = Color,
								},
								Scope:ProgressBar {
									Direction = Enum.FillDirection.Vertical,
									Progress = Progress,
									Color = Color,
								},
								Scope:ProgressBar {
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

		return function()
			Scope:doCleanup()
		end
	end,
}
