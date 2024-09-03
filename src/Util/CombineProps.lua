local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)

--[=[
		@function CombineProps
		@within Util

		@param Source { [any]: Fusion.UsedAs<any> }
		@param Target { [any]: Fusion.UsedAs<any> }
		@param ExcludedKeys { any }?
		
		Combines two sets of props for easy passthrough, adding `Source`'s props to `Target`.
]=]
local function CombineProps(
	Source: { [any]: Fusion.UsedAs<any> },
	Target: { [any]: Fusion.UsedAs<any> },
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
