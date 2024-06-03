local PubTypes = require(script.Parent.Parent.PubTypes)

local function GetValue(Value: PubTypes.CanBeState<nil>): any
	if (typeof(Value) == "table") and (typeof(Value.type) == "string") then
		return Value:get()
	else
		return Value
	end
end

return GetValue
