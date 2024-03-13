local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local Colors = require(OnyxUI.Utils.Colors)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Value = Fusion.Value

local Frame = require(OnyxUI.Components.Frame)
local Badge = require(OnyxUI.Components.Badge)

return function(Target: Instance)
	local NotificationCount = Value(0)

	local CountLoop = task.spawn(function()
		for Count = 1, 10 do
			NotificationCount:set(Count)
			task.wait(0.5)
		end
	end)

	local Instance = Frame {
		Parent = Target,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		[Children] = {
			New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				Padding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
				end),
			},
			Badge {
				Contents = { "BADGE" },
			},
			Badge {
				Contents = { "rbxassetid://5422855103", "PREMIUM" },
				Color = Colors.Amber["500"],
			},
			Badge {
				Contents = { "🕑 50% OFF" },
				Color = Colors.Red["500"],
			},
			Badge {
				Contents = Computed(function()
					if NotificationCount:get() == 10 then
						return { "9+" }
					else
						return { NotificationCount:get() }
					end
				end),
				Color = Themer.Theme.Colors.Primary.Main,
			},
		},
	}

	return function()
		Instance:Destroy()
		coroutine.close(CountLoop)
	end
end
