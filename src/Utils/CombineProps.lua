local OnyxUI = script.Parent.Parent
local PubTypes = require(OnyxUI.Utils.PubTypes)

local function CombineProps(Source: { [any]: PubTypes.CanBeState<any> }, Target: { [any]: PubTypes.CanBeState<any> }, ExcludedKeys: { any }?)
	for Key, Value in pairs(Source) do
		if (ExcludedKeys ~= nil) and (table.find(ExcludedKeys, Key) ~= nil) then
			continue
		end

		Target[Key] = Value
	end

	return Target
end

return CombineProps
