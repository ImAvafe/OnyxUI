local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local PubTypes = require(script.Parent.Parent.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local Frame = require(script.Parent.Frame)

export type Props = Frame.Props & {
	Progress: PubTypes.CanBeState<number>?,
	Color: PubTypes.CanBeState<Color3>?,
}

return function(Props: Props)
	local Progress = EnsureValue(Props.Progress, "number", 0)
	local Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)

	local CornerRadius = Computed(function()
		return UDim.new(0, Themer.Theme.CornerRadius["2"]:get())
	end)

	return Frame(CombineProps(Props, {
		Name = "ProgressBar",
		Size = Computed(function()
			return UDim2.fromOffset(250, Themer.Theme.TextSize["1"]:get())
		end),
		AutomaticSize = Enum.AutomaticSize.None,
		BackgroundTransparency = 0,
		BackgroundColor3 = Themer.Theme.Colors.Neutral.Dark,
		CornerRadius = CornerRadius,

		[Children] = {
			Frame {
				Name = "ProgressFill",
				Size = Spring(
					Computed(function()
						return UDim2.fromScale(Progress:get(), 1)
					end),
					Themer.Theme.SpringSpeed["0.5"],
					Themer.Theme.SpringDampening
				),
				AutomaticSize = Enum.AutomaticSize.None,
				BackgroundTransparency = 0,
				BackgroundColor3 = Color,
				CornerRadius = CornerRadius,
			},
		},
	}))
end
