local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Value = Fusion.Value
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local ProgressBar = require(OnyxUI.Components.ProgressBar)

return function(Target: Instance)
	local Progress = Value(0)
	local Color = Value(Color3.fromRGB(255, 0, 0))

	local Instance = Frame {
		Parent = Target,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		[Children] = {
			New "UIListLayout" {
				Padding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
				end),
			},
			ProgressBar {
				Parent = Target,
				Progress = 0.75,
			},
			ProgressBar {
				Parent = Target,
				Progress = Progress,
				Color = Color,
			},
			ProgressBar {
				Parent = Target,
				Progress = Progress,
				Color = Color,
				SpringDampening = 0.5,
				SpringSpeed = 30,
			},
		},
	}

	task.spawn(function()
		while task.wait(1) do
			Progress:set(math.random(0, 1000) / 1000)
			Color:set(ColourUtils.Rotate(Color:get(), 100))
		end
	end)

	return function()
		Instance:Destroy()
	end
end