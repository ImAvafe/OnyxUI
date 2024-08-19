local OnyxUI = require(script.Parent.Parent.Parent)
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
			Main = Colors.Stone["800"],
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
	Font = {
		Body = "rbxassetid://12187371840",
		Heading = "rbxassetid://12187371840",
		Monospace = "rbxassetid://12187371840",
	},
	FontWeight = {
		Body = Enum.FontWeight.Bold,
		Bold = Enum.FontWeight.ExtraBold,
		Heading = Enum.FontWeight.ExtraBold,
	},
	TextSize = {
		Base = 18,
	},
	CornerRadius = {
		Base = 0,
	},
	StrokeThickness = {
		Base = 2,
	},
	Spacing = {
		Base = 28,
	},
	SpringSpeed = {
		Base = 60,
	},
	SpringDampening = 0.75,
}
