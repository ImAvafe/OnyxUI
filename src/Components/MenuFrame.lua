local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Value = Fusion.Value
local Out = Fusion.Out

local Frame = require(script.Parent.Frame)
local CanvasGroup = require(script.Parent.CanvasGroup)

type Props = CanvasGroup.Props & {}

return function(Props: Props)
	local AutomaticSize = Value(Enum.AutomaticSize.None)

	return CanvasGroup(CombineProps(Props, {
		Name = "MenuFrame",
		GroupTransparency = Props.GroupTransparency,
		BackgroundColor3 = Themer.Theme.Colors.Base.Main,
		BackgroundTransparency = 0,
		Padding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end),
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["3"]:get())
		end),
		StrokeEnabled = true,
		StrokeColor = Themer.Theme.Colors.Neutral.Main,

		[Out "AutomaticSize"] = AutomaticSize,

		[Children] = {
			Frame {
				Name = "Contents",
				AutomaticSize = Props.AutomaticSize,
				Size = Computed(function()
					local AutomaticSizeScales = {
						[Enum.AutomaticSize.None] = UDim2.fromScale(1, 1),
						[Enum.AutomaticSize.XY] = UDim2.fromScale(0, 0),
						[Enum.AutomaticSize.X] = UDim2.fromScale(0, 1),
						[Enum.AutomaticSize.Y] = UDim2.fromScale(1, 0),
					}
					return AutomaticSizeScales[AutomaticSize:get()]
				end),

				[Children] = Props[Children],
			},
		},
	}, { Children }))
end
