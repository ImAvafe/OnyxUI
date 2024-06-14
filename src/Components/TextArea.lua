local OnyxUI = script.Parent.Parent
local CombineProps = require(OnyxUI.Utils.CombineProps)

local TextInput = require(OnyxUI.Components.TextInput)

export type Props = TextInput.Props & {}

return function(Props: Props)
	return TextInput(CombineProps(Props, {
		AutomaticSize = Enum.AutomaticSize.None,
		TextWrapped = true,
		MultiLine = true,
	}))
end
