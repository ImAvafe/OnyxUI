local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)

local peek = Fusion.peek

return function(Value: Fusion.UsedAs<any>, Fallback: any)
	if peek(Value) == nil then
		if typeof(Value) == "table" and Value.kind == "Value" then
			Value:set(Fallback)
			return Value
		else
			return Fallback
		end
	else
		return Value
	end
end
