local NekaUI = script.Parent.Parent

local AutomaticSizer = require(NekaUI.Utils.AutomaticSizer)

return function(Instance: Instance)
  if not Instance:GetAttribute("Finalized") then
    AutomaticSizer.AutomaticSize(Instance)

    Instance:SetAttribute("Finalized", true)
  end

  return Instance
end