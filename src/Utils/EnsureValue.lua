local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)

local Value = Fusion.Value

return function(PreferredValue: any, ValueType: string, FallbackValue: any): Fusion.CanBeState<any>
	if PreferredValue == nil then
		if typeof(FallbackValue) == "table" and FallbackValue.get then
			return FallbackValue
		else
			return Value(FallbackValue)
		end
	elseif (typeof(PreferredValue) == ValueType) and not (typeof(PreferredValue) == "table" and PreferredValue.get) then
		return Value(PreferredValue)
	else
		return PreferredValue
	end
end
