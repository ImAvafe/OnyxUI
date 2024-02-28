local OnyxUI = script.Parent.Parent.Parent

local Colors = require(OnyxUI.Utils.Colors)

return {
	Colors = {
		Primary = {
			Main = Colors.Violet["500"],
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
		Body = "rbxasset://fonts/families/GothamSsm.json",
		Heading = "rbxasset://fonts/families/GothamSSm.json",
		Monospace = "rbxasset://fonts/families/GothamSSm.json",
	},
	FontWeights = {
		Body = Enum.FontWeight.Medium,
		Bold = Enum.FontWeight.Bold,
		Heading = Enum.FontWeight.Bold,
	},
	TextSizes = {
		["1"] = 12,
		["2"] = 14,
		["3"] = 16,
		["4"] = 18,
		["5"] = 20,
		["6"] = 24,
		["7"] = 30,
		["8"] = 36,
		["9"] = 48,
		["10"] = 60,
		["11"] = 72,
	},
	CornerRadius = 8,
	StrokeThickness = 2,
	Space = 4,
	SpringSpeed = 40,
}
