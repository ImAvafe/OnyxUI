local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local PubTypes = require(OnyxUI.Utils.PubTypes)

local Value = Fusion.Value

return function(PreferredValue: any, ValueType: string, FallbackValue: any): PubTypes.CanBeState<any>
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
