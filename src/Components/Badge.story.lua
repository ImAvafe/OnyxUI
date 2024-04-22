local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local Colors = require(OnyxUI.Utils.Colors)
local Modifier = require(OnyxUI.Utils.Modifier)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Value = Fusion.Value

local Frame = require(OnyxUI.Components.Frame)
local Badge = require(OnyxUI.Components.Badge)
local Text = require(OnyxUI.Components.Text)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local NotificationCount = Value(0)

		local CountLoop = task.spawn(function()
			while task.wait(0.08) do
				if NotificationCount:get() == 100 then
					task.wait(3)
					NotificationCount:set(1)
				else
					NotificationCount:set(NotificationCount:get() + 1)
				end
			end
		end)

		local Instance = Frame {
			Parent = Parent,

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
						if NotificationCount:get() >= 100 then
							return { "99+" }
						else
							return { NotificationCount:get() }
						end
					end),
					Color = Themer.Theme.Colors.Primary.Main,
				},
				Frame {
					[Children] = {
						Modifier.ListLayout {
							FillDirection = Enum.FillDirection.Horizontal,
						},

						Text {
							Text = "$25",
						},
						Badge {
							Contents = { "-50%" },
							Color = Colors.Red["500"],
						},
					},
				},
			},
		}

		return function()
			Instance:Destroy()
			coroutine.close(CountLoop)
		end
	end,
}
