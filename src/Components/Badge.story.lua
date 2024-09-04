local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped
local Children = Fusion.Children
local peek = Fusion.peek

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
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local NotificationCount = Scope:Value(0)

		local CountThread = task.spawn(function()
			while task.wait(0.08) do
				if peek(NotificationCount) == 100 then
					task.wait(3)
					NotificationCount:set(1)
				else
					NotificationCount:set(peek(NotificationCount) + 1)
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
			ListPadding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.Spacing["0.5"]))
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
					Content = Scope:Computed(function(use)
						if use(NotificationCount) >= 100 then
							return { "99+" }
						else
							return { use(NotificationCount) }
						end
					end),
					Color = Theme.Colors.Primary.Main,
				},
				Scope:Frame {
					ListEnabled = true,
					ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
					ListFillDirection = Enum.FillDirection.Horizontal,
					ListPadding = Scope:Computed(function(use)
						return UDim.new(0, use(Theme.Spacing["0.25"]))
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
