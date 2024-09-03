local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)

local peek = Fusion.peek

--[=[
	@function EnsureValue
	@within Util

	@param Scope Fusion.Scope<any>
	@param Value Fusion.UsedAs<any>
	
	Converts the `PreferredValue` to a Fusion `Value` object, if it is not one already.
]=]
return function(Scope: Fusion.Scope<any>, Value: Fusion.UsedAs<any>): Fusion.Value<any>
	if (typeof(Value) == "table") and (Value.kind == "Value") then
		return Value
	else
		return Fusion.Value(Scope, peek(Value))
	end
end
