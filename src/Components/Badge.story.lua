local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped
local Children = Fusion.Children
local Peek = Fusion.peek

local Frame = require(OnyxUI.Components.Frame)
local Badge = require(OnyxUI.Components.Badge)
local Text = require(OnyxUI.Components.Text)
local Components = {
	Frame = Frame,
	Badge = Badge,
	Text = Text,
}

return {
	story = function(Parent: GuiObject)
		local Scope = Scoped(Fusion, Components)
		local Theme = Themer.Theme:now()

		local NotificationCount = Scope:Value(0)

		local CountThread = task.spawn(function()
			while task.wait(0.08) do
				if Peek(NotificationCount) == 100 then
					task.wait(3)
					NotificationCount:set(1)
				else
					NotificationCount:set(Peek(NotificationCount) + 1)
				end
			end
		end)

		Scope:innerScope({
			function()
				task.cancel(CountThread)
			end,
		})

		Scope:Frame {
			Parent = Parent,
			ListEnabled = true,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.5"]))
			end),

			[Children] = {
				Scope:Badge {
					Content = { "Badge" },
				},
				Scope:Badge {
					Content = { " PREMIUM" },
					Color = Util.Colors.Amber["500"],
				},
				Scope:Badge {
					Content = { "rbxassetid://103798699021677", "-50%" },
					Color = Util.Colors.Red["500"],
				},
				Scope:Badge {
					Content = { "rbxassetid://140490867216758", "LIMITED" },
					Color = Util.Colors.Red["500"],
				},
				Scope:Badge {
					Content = Scope:Computed(function(Use)
						if Use(NotificationCount) >= 100 then
							return { "99+" }
						else
							return { Use(NotificationCount) }
						end
					end),
					Color = Theme.Colors.Primary.Main,
				},
				Scope:Frame {
					ListEnabled = true,
					ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
					ListFillDirection = Enum.FillDirection.Horizontal,
					ListPadding = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.Spacing["0.25"]))
					end),

					[Children] = {
						Scope:Text {
							Text = "It's also proportional alongside text.",
						},
						Scope:Badge {
							Content = { "rbxassetid://137979359742656", "TRUE" },
							Color = Util.Colors.Green["500"],
						},
					},
				},
			},
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
