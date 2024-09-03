local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Value = Fusion.Value

--[=[
	@function EnsureValue
	@within Util

	@param PreferredValue any
	@param ValueType string
	@param FallbackValue any
	
	Converts the `PreferredValue` to a Fusion `Value` object, if it is not one already. Also supports an optional fallback value.
]=]
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
