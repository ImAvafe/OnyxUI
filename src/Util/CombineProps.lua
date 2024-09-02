local OnyxUI = script.Parent.Parent
local PubTypes = require(OnyxUI.Util.PubTypes)

--[=[
		@function CombineProps
		@within Util

		@param Source { [any]: PubTypes.CanBeState<any> }
		@param Target { [any]: PubTypes.CanBeState<any> }
		@param ExcludedKeys { any }?
		
		Combines two sets of props for easy passthrough, adding `Source`'s props to `Target`.
]=]
local function CombineProps(
	Source: { [any]: PubTypes.CanBeState<any> },
	Target: { [any]: PubTypes.CanBeState<any> },
	ExcludedKeys: { any }?
)
	for Key, Value in pairs(Source) do
		if (ExcludedKeys ~= nil) and (table.find(ExcludedKeys, Key) ~= nil) then
			continue
		end

		Target[Key] = Value
	end

	return Target
end

return CombineProps
