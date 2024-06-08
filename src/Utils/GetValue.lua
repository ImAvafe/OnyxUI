local OnyxUI = script.Parent.Parent
local PubTypes = require(OnyxUI.Utils.PubTypes)

local function GetValue(Value: PubTypes.CanBeState<any>): any
	if (typeof(Value) == "table") and (typeof(Value.type) == "string") then
		return Value:get()
	else
		return Value
	end
end

return GetValue
