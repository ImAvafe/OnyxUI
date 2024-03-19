local Modifiers = {}

for Name, Modifier in ipairs(script:GetChildren()) do
	Modifiers[Name] = require(Modifier)
end

return Modifiers
