local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local Value = Fusion.Value

return {
	Colors = {
		Primary = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},
		Secondary = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},
		Accent = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},

		Neutral = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},
		NeutralContent = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},

		Base = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},
		BaseContent = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},

		Success = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},
		Error = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},
		Warning = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},
		Info = {
			Main = Value(nil),
			Dark = Value(nil),
			Light = Value(nil),
			Contrast = Value(nil),
		},
	},
	Fonts = {
		Body = Value("GothamSsm"),
		Heading = Value("GothamSsm"),
		Monospace = Value("GothamSsm"),
	},
	FontWeights = {
		Body = Value(Enum.FontWeight.Regular),
		Bold = Value(Enum.FontWeight.Bold),
		Heading = Value(Enum.FontWeight.Bold),
	},
	TextSizes = {
		Base = Value(16),
		["0.75"] = Value(nil),
		["0.875"] = Value(nil),
		["1"] = Value(nil),
		["1.125"] = Value(nil),
		["1.25"] = Value(nil),
		["1.5"] = Value(nil),
		["1.875"] = Value(nil),
		["2.25"] = Value(nil),
		["3"] = Value(nil),
		["3.75"] = Value(nil),
		["4.5"] = Value(nil),
	},
	Spacings = {
		Base = Value(16),
		["0.25"] = Value(nil),
		["0.5"] = Value(nil),
		["0.75"] = Value(nil),
		["1"] = Value(nil),
		["1.5"] = Value(nil),
		["2"] = Value(nil),
		["3"] = Value(nil),
		["4"] = Value(nil),
		["6"] = Value(nil),
		["8"] = Value(nil),
		["12"] = Value(nil),
		["16"] = Value(nil),
		["24"] = Value(nil),
		["32"] = Value(nil),
		["40"] = Value(nil),
		["48"] = Value(nil),
	},
	CornerRadius = Value(8),
	StrokeThickness = Value(2),
	SpringSpeed = Value(0.1),
}
