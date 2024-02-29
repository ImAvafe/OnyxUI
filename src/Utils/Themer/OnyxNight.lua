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
	Font = {
		Body = "rbxasset://fonts/families/GothamSsm.json",
		Heading = "rbxasset://fonts/families/GothamSSm.json",
		Monospace = "rbxasset://fonts/families/GothamSSm.json",
	},
	FontWeight = {
		Body = Enum.FontWeight.Medium,
		Bold = Enum.FontWeight.Bold,
		Heading = Enum.FontWeight.Bold,
	},
	TextSize = {
		Base = 18,
	},
	CornerRadius = {
		Base = 6,
	},
	StrokeThickness = {
		Base = 2,
	},
	Spacing = {
		Base = 16,
	},
	SpringSpeed = {
		Base = 40,
	},
}
