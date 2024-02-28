local OnyxUI = script.Parent.Parent.Parent

local Colors = require(OnyxUI.Utils.Colors)

return {
	Colors = {
		Primary = {
			Main = Colors.White,
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
			Main = Colors.Black,
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
		Body = "rbxassetid://12187371840",
		Heading = "rbxassetid://12187371840",
		Monospace = "rbxassetid://12187371840",
	},
	FontWeights = {
		Body = Enum.FontWeight.Bold,
		Bold = Enum.FontWeight.ExtraBold,
		Heading = Enum.FontWeight.ExtraBold,
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
	CornerRadius = 0,
	StrokeThickness = 2,
	Space = 8,
	SpringSpeed = 80,
}
