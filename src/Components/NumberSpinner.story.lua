local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Value = Fusion.Value

local Frame = require(OnyxUI.Components.Frame)
local NumberSpinner = require(OnyxUI.Components.NumberSpinner)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local RandomNumber = Value(0)
		local RandomDecimalNumber = Value(0)
		local CountNumber = Value(0)

		local RandomizerThread = task.spawn(function()
			while task.wait(1) do
				RandomNumber:set(math.random(1, 1000000))
			end
		end)
		local RandomizerDecimalThread = task.spawn(function()
			while task.wait(1) do
				RandomDecimalNumber:set(math.random(1, 10000) / 100)
			end
		end)
		local CountThread = task.spawn(function()
			while task.wait(1) do
				CountNumber:set(CountNumber:get() + 1)
			end
		end)

		local Instance = Frame {
			Parent = Parent,
			Size = UDim2.fromOffset(300, 0),
			AutomaticSize = Enum.AutomaticSize.Y,

			[Children] = {
				New "UIListLayout" {
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Vertical,
				},
				NumberSpinner {
					Value = CountNumber,
				},
				NumberSpinner {
					Value = RandomNumber,
					Commas = true,
				},
				NumberSpinner {
					Value = RandomDecimalNumber,
					Decimals = 2,
					Commas = true,
					Prefix = "$",
					Font = Enum.Font.FredokaOne,
				},
			},
		}

		return function()
			task.cancel(RandomizerThread)
			task.cancel(RandomizerDecimalThread)
			task.cancel(CountThread)
			Instance:Destroy()
		end
	end,
}
