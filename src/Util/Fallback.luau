--[=[
	@function Fallback
	@within Util

	@param Value Fusion.UsedAs<any>
	@param Fallback any
	@return any
	
	Defaults the given `Value` to `Fallback` if nil.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)

local Peek = Fusion.peek

return function(Value: Fusion.UsedAs<any>, Fallback: any)
	if Peek(Value) == nil then
		if (typeof(Value) == "table") and (Value.kind == "Value") and (Value.set ~= nil) then
			Value:set(Fallback)
			return Value
		else
			return Fallback
		end
	else
		return Value
	end
end
