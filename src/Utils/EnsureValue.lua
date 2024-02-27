local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local Value = Fusion.Value

return function(PreferredValue: any, ValueType: string, DefaultValue: any?)
	if PreferredValue == nil then
		if typeof(DefaultValue) == "table" and DefaultValue.get then
			return DefaultValue
		else
			return Value(DefaultValue)
		end
	elseif (typeof(PreferredValue) == ValueType) and not (typeof(PreferredValue) == "table" and PreferredValue.get) then
		return Value(PreferredValue)
	else
		return PreferredValue
	end
end
