local OnyxUI = require(script.Parent.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New

type Props = {
	Name: any?,
	Parent: any?,
	Enabled: any?,
	Color: any?,
	Thickness: any?,
	Transparency: any?,
	LineJoinMode: any?,
	ApplyStrokeMode: any?,
}

return function(Props: Props)
	Props.Thickness = EnsureValue(Props.Thickness, "number", Themer.Theme.StrokeThickness["1"])
	Props.Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Neutral.Main)
	Props.ApplyStrokeMode = EnsureValue(Props.ApplyStrokeMode, "Enum.ApplyStrokeMode", Enum.ApplyStrokeMode.Border)

	return New "UIStroke" {
		Name = Props.Name,
		Parent = Props.Parent,
		Enabled = Props.Enabled,
		Color = Props.Color,
		Thickness = Props.Thickness,
		Transparency = Props.Transparency,
		LineJoinMode = Props.LineJoinMode,
		ApplyStrokeMode = Props.ApplyStrokeMode,
	}
end
