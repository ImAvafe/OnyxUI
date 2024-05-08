local OnyxUI = require(script.Parent.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)

local Value = Fusion.Value
local New = Fusion.New

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
	Font = {
		Body = Value("GothamSsm"),
		Heading = Value("GothamSsm"),
		Monospace = Value("GothamSsm"),
	},
	FontWeight = {
		Body = Value(Enum.FontWeight.Regular),
		Bold = Value(Enum.FontWeight.Bold),
		Heading = Value(Enum.FontWeight.Bold),
	},
	TextSize = {
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
	Spacing = {
		Base = Value(16),
		["0"] = Value(0),
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
	CornerRadius = {
		Base = Value(4),
		["0"] = Value(0),
		["0.5"] = Value(nil),
		["1"] = Value(nil),
		["1.5"] = Value(nil),
		["2"] = Value(nil),
		["3"] = Value(nil),
		["4"] = Value(nil),
		["6"] = Value(nil),
		Full = Value(9999),
	},
	StrokeThickness = {
		Base = Value(2),
		["0"] = Value(0),
		["1"] = Value(nil),
		["2"] = Value(nil),
		["3"] = Value(nil),
		["4"] = Value(nil),
		["8"] = Value(nil),
	},
	SpringSpeed = {
		Base = Value(40),
		["0.1"] = Value(nil),
		["0.175"] = Value(nil),
		["0.25"] = Value(nil),
		["0.375"] = Value(nil),
		["0.5"] = Value(nil),
		["0.75"] = Value(nil),
		["1"] = Value(nil),
		["1.5"] = Value(nil),
		["2"] = Value(nil),
		Immediate = Value(1000),
	},
	SpringDampening = Value(1),
	Emphasis = Value(0.15),
	Sound = {
		Hover = Value(New "Sound" {
			SoundId = "rbxassetid://10066936758",
			Volume = 0.05,
		}),
		Click = Value(New "Sound" {
			SoundId = "rbxassetid://16480549841",
			Volume = 0.5,
		}),
		Focus = Value(New "Sound" {
			SoundId = "rbxassetid://16480549841",
			Volume = 0.5,
		}),
		Switch = Value(New "Sound" {
			SoundId = "rbxassetid://9119713951",
			Volume = 0.5,
		}),
	},
}
