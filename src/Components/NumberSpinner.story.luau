local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local Children = Fusion.Children
local Scoped = Fusion.scoped
local Peek = Fusion.peek

local Frame = require(OnyxUI.Components.Frame)
local NumberSpinner = require(OnyxUI.Components.NumberSpinner)
local Components = {
	Frame = Frame,
	NumberSpinner = NumberSpinner,
}

return {
	story = function(Props)
		local Scope = Fusion.innerScope(Props.scope, Fusion, Components)

		local RandomNumber = Scope:Value(0)
		local RandomDecimalNumber = Scope:Value(0)
		local CountNumber = Scope:Value(0)

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
				CountNumber:set(Peek(CountNumber) + 1)
			end
		end)

		Scope:innerScope({
			function()
				task.cancel(RandomizerThread)
				task.cancel(RandomizerDecimalThread)
				task.cancel(CountThread)
			end,
		})

		Scope:Frame {
			Parent = Props.target,
			Size = UDim2.fromOffset(300, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,

			[Children] = {
				Scope:NumberSpinner {
					Value = CountNumber,
				},
				Scope:NumberSpinner {
					Value = RandomNumber,
					Commas = true,
				},
				Scope:NumberSpinner {
					Value = RandomDecimalNumber,
					Decimals = 2,
					Commas = true,
					Prefix = "$",
					Font = Enum.Font.FredokaOne,
				},
			},
		}
	end,
	fusion = Fusion,
}
