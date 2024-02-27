local OnyxUI = script.Parent.Parent.Parent

local Colors = require(OnyxUI.Utils.Colors)

return {
	Colors = {
		Primary = {
			Main = Colors.Violet["400"],
			Contrast = Colors.White,
		},
		Secondary = {
			Main = Colors.White,
		},
		Accent = {
			Main = Colors.White,
		},

		Neutral = {
			Main = Colors.Stone["700"],
		},
		NeutralContent = {
			Main = Colors.Stone["300"],
		},

		Base = {
			Main = Colors.Stone["900"],
		},
		BaseContent = {
			Main = Colors.White,
		},

		Success = {
			Main = Colors.Green["500"],
		},
		Error = {
			Main = Colors.Red["500"],
		},
		Warning = {
			Main = Colors.Amber["500"],
		},
		Info = {
			Main = Colors.Cyan["400"],
		},
	},
	Fonts = {
		Body = "GothamSsm",
		Heading = "GothamSsm",
		Monospace = "GothamSsm",
	},
	FontWeights = {
		Body = Enum.FontWeight.Medium,
		Bold = Enum.FontWeight.Bold,
		Heading = Enum.FontWeight.Bold,
	},
	TextSize = 18,
	CornerRadius = 8,
	StrokeThickness = 2,
	Space = 4,
	TransitionTime = 0.1,
}
