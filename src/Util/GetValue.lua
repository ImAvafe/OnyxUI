local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)

local function GetValue(Value: Fusion.UsedAs<any>): any
	if (typeof(Value) == "table") and (typeof(Value.type) == "string") then
		return Value:get()
	else
		return Value
	end
end

return GetValue
