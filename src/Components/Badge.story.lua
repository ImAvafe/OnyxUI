local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

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
			ListEnabled = true,
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
			end),

			[Children] = {
				Badge {
					Contents = { "Badge" },
				},
				Badge {
					Contents = { " PREMIUM" },
					Color = Util.Colors.Amber["500"],
				},
				Badge {
					Contents = { "rbxassetid://103798699021677", "-50%" },
					Color = Util.Colors.Red["500"],
				},
				Badge {
					Contents = { "rbxassetid://140490867216758", "LIMITED" },
					Color = Util.Colors.Red["500"],
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
					ListEnabled = true,
					ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
					ListFillDirection = Enum.FillDirection.Horizontal,
					ListPadding = Computed(function()
						return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
					end),

					[Children] = {
						Text {
							Text = "It's also proportional alongside text.",
						},
						Badge {
							Contents = { "rbxassetid://137979359742656", "TRUE" },
							Color = Util.Colors.Green["500"],
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
