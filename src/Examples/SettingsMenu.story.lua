local SettingsMenu = require(script.Parent.SettingsMenu)

return {
	story = function(Parent: GuiObject, _Props: table)
		local Instance = SettingsMenu {
			Parent = Parent,
		}

		return function()
			Instance:Destroy()
		end
	end,
}
