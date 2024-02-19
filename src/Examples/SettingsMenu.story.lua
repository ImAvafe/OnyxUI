local SettingsMenu = require(script.Parent.SettingsMenu)

return function(Target: Instance)
  local Instance = SettingsMenu {
    Parent = Target,
  }

  return function()
    Instance:Destroy()
  end
end