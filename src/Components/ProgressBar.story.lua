local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)

local Children = Fusion.Children
local Value = Fusion.Value

local Frame = require(script.Parent.Frame)
local ProgressBar = require(script.Parent.ProgressBar)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Progress = Value(0)
		local Color = Value(Color3.fromRGB(255, 0, 0))

		local Instance = Frame {
			Parent = Parent,
			ListEnabled = true,

			[Children] = {
				ProgressBar {
					Progress = 0.75,
				},
				ProgressBar {
					Progress = Progress,
					Color = Color,
				},
				ProgressBar {
					Progress = Progress,
					Color = Color,
				},
			},
		}

		task.spawn(function()
			while task.wait(1) do
				Progress:set(math.random(0, 1000) / 1000)
				Color:set(ColorUtils.Rotate(Color:get(), 100))
			end
		end)

		return function()
			Instance:Destroy()
		end
	end,
}
